<?php

namespace Sf\QuranBundle\Controller;

use Sf\CoreBundle\Controller\CoreController as Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Component\HttpFoundation\Response;
use Sf\QuranBundle\Entity\Playlist;
use Sf\QuranBundle\Entity\PlaylistItem;
use Sf\UserBundle\Entity\User;
use Doctrine\Common\Collections\ArrayCollection;

class PlaylistController extends Controller
{
    /**
     * @Template()
     */
    public function listAction()
    {
        if (!$this->checkIfAuthenticated()) {
            return $this->redirectToLogin();
        }

        $em = $this->getDoctrine()->getManager();
        $user = $this->getCurrentUser();

        $repos = $em->getRepository('QuranBundle:Playlist');
        $playlists = $repos->findBy(array('user' => $user));
        return array('playlists' => $playlists);
    }

    /**
     * @Template()
     */
    public function createAction()
    {
        if (!$this->checkIfAuthenticated()) {
            return $this->redirectToLogin();
        }
        return array();
    }

    /**
     * @Template()
     */
    public function listAjaxAction($type)
    {
        if (!$this->checkIfAuthenticated()) {
            return $this->redirectToLogin();
        }
        $em = $this->getDoctrine()->getManager();

        $objectList = array();
        $chapterList = array();

        if ($type == 'reciter') {
            $rChapterList = $em->getRepository('QuranBundle:Chapter');
            $chapterList = $rChapterList->findAll();

            $rReciters = $em->getRepository('QuranBundle:QuranReciter');
            $objectList = $rReciters->findAll();
        }
        if ($type == 'adhkar') {
            $rAdhkarList = $em->getRepository('QuranBundle:Adhkar');
            $objectList = $rAdhkarList->findAll();
        }
        if ($type == 'tilawa') {
            $rTilawat = $em->getRepository('QuranBundle:Tilawa');
            $objectList = $rTilawat->findAll();
        }
        return array('type' => $type, 'chapterList' => $chapterList, 'objectList' => $objectList);
    }

    /**
     * @return \Symfony\Component\HttpFoundation\RedirectResponse|\Symfony\Component\HttpFoundation\Response
     */
    public function saveAction()
    {
        if (!$this->checkIfAuthenticated()) {
            return $this->redirectToLogin();
        }

        $response = new Response();

        $em = $this->getDoctrine()->getManager();
        $user = $this->getCurrentUser();

        $datas = $this->getRequest()->get('data');
        $name = $this->getRequest()->get('name');

        if (count($datas) > 0) {

            $playlist = new Playlist();
            $playlist
                ->setName($name)
                ->setUser($user);

            $rReciters = $em->getRepository('QuranBundle:QuranReciter');
            $rChapter = $em->getRepository('QuranBundle:Chapter');
            $rAdhkar = $em->getRepository('QuranBundle:Adhkar');
            $rTilawa = $em->getRepository('QuranBundle:Tilawa');

            foreach ($datas as $data) {
                $type = $data[2];
                if ($type == "chapter") {
                    $reciter = $rReciters->findOneBy(array('id' => $data[0]));
                    $chapter = $rChapter->findOneBy(array('id' => $data[1]));
                    if ($reciter && $chapter) {
                        $item = new PlaylistItem();
                        $item
                            ->setReciter($reciter)
                            ->setChapter($chapter)
                            ->setPlaylist($playlist)
                            ->setType($type);
                        $playlist->addItems($item);
                        $em->persist($item);
                    }
                } elseif ($type == "adhkar") {
                    $adhkar = $rAdhkar->findOneBy(array('id' => $data[0]));
                    if ($adhkar) {
                        $item = new PlaylistItem();
                        $item
                            ->setAdhkar($adhkar)
                            ->setPlaylist($playlist)
                            ->setType($type);
                        $playlist->addItems($item);
                        $em->persist($item);
                    }
                } elseif ($type == "tilawa") {
                    $tilawa = $rTilawa->findOneBy(array('id' => $data[0]));
                    if ($tilawa) {
                        $item = new PlaylistItem();
                        $item
                            ->setTilawa($tilawa)
                            ->setPlaylist($playlist)
                            ->setType($type);
                        $playlist->addItems($item);
                        $em->persist($item);
                    }
                }
            }
            $em->persist($playlist);
            $em->flush();
            $this->get('session')->getFlashBag()->add(
                'success',
                'playlist.created_successful'
            );
            $response->setContent($this->generateUrl('playlist_list'));
        }
        return $response;
    }

    /**
     * @Template()
     */
    public function playAction(Playlist $playList)
    {
        if (!$this->checkIfAuthenticated()) {
            return $this->redirectToLogin();
        }

        $user = $this->getCurrentUser();
        if ($playList->getUser()->getId() != $user->getId()) {
            $this->get('session')->getFlashBag()->add(
                'error',
                'playlist.you_dont_have_permission'
            );
            return $this->redirect($this->generateUrl('playlist_list'));
        }

        if (!$playList) {
            throw new \Symfony\Component\HttpKernel\Exception\NotFoundHttpException();
        }

        $items = $playList->getItems();
        return array('items' => $items, 'playlist' => $playList);
    }

    /**
     * @Template()
     */
    public function editAction(Playlist $playList)
    {
        if (!$this->checkIfAuthenticated()) {
            return $this->redirectToLogin();
        }

        $em = $this->getDoctrine()->getManager();
        $user = $this->getCurrentUser();
        if ($playList->getUser()->getId() != $user->getId()) {
            $this->get('session')->getFlashBag()->add(
                'error',
                'playlist.you_dont_have_permission'
            );
            return $this->redirect($this->generateUrl('playlist_list'));
        }

        $rReciters = $em->getRepository('QuranBundle:QuranReciter');
        $recitersList = $rReciters->findAll();
        $rChapterList = $em->getRepository('QuranBundle:Chapter');
        $chapterList = $rChapterList->findAll();
        $rAdhkarList = $em->getRepository('QuranBundle:Adhkar');
        $adhkarList = $rAdhkarList->findAll();
        $rTilawat = $em->getRepository('QuranBundle:Tilawa');
        $tilawatList = $rTilawat->findAll();

        return array('tilawatList' => $tilawatList, 'adhkarList' => $adhkarList, 'playlist' => $playList, 'chapterList' => $chapterList, 'recitersList' => $recitersList);
    }

    public function editSaveAction(Playlist $playlist)
    {
        if (!$this->checkIfAuthenticated()) {
            return $this->redirectToLogin();
        }

        $response = new Response();

        $em = $this->getDoctrine()->getManager();
        $user = $this->getCurrentUser();

        $datas = $this->getRequest()->get('data');
        $name = $this->getRequest()->get('name');

        if ($playlist->getUser()->getId() != $user->getId()) {
            $this->get('session')->getFlashBag()->add(
                'error',
                'playlist.you_dont_have_permission'
            );
            return $this->redirect($this->generateUrl('playlist_list'));
        }

        $items = $playlist->getItems();
        foreach ($items as $item) {
            $em->remove($item);
        }
        $em->persist($playlist);


        $playlist->setName($name);

        $rReciters = $em->getRepository('QuranBundle:QuranReciter');
        $rChapter = $em->getRepository('QuranBundle:Chapter');
        $rAdhkar = $em->getRepository('QuranBundle:Adhkar');
        $rTilawa = $em->getRepository('QuranBundle:Tilawa');

        if (count($datas) > 0) {
            foreach ($datas as $data) {
                $type = $data[2];
                if ($type == "chapter") {
                    $reciter = $rReciters->findOneBy(array('id' => $data[0]));
                    $chapter = $rChapter->findOneBy(array('id' => $data[1]));
                    if ($reciter && $chapter) {
                        $item = new PlaylistItem();
                        $item
                            ->setReciter($reciter)
                            ->setChapter($chapter)
                            ->setPlaylist($playlist)
                            ->setType($type);
                        $playlist->addItems($item);
                        $em->persist($item);
                    }
                } elseif ($type == "adhkar") {
                    $adhkar = $rAdhkar->findOneBy(array('id' => $data[0]));
                    if ($adhkar) {
                        $item = new PlaylistItem();
                        $item
                            ->setAdhkar($adhkar)
                            ->setPlaylist($playlist)
                            ->setType($type);
                        $playlist->addItems($item);
                        $em->persist($item);
                    }
                } elseif ($type == "tilawa") {
                    $tilawa = $rTilawa->findOneBy(array('id' => $data[0]));
                    if ($tilawa) {
                        $item = new PlaylistItem();
                        $item
                            ->setTilawa($tilawa)
                            ->setPlaylist($playlist)
                            ->setType($type);
                        $playlist->addItems($item);
                        $em->persist($item);
                    }
                }
            }
        }
        $em->persist($playlist);
        $em->flush();
        $this->get('session')->getFlashBag()->add(
            'success',
            'playlist.edited_successful'
        );
        $response->setContent($this->generateUrl('playlist_list'));
        return $response;
    }

    public function deleteAction(Playlist $playList)
    {
        $response = new Response();

        if (!$this->checkIfAuthenticated()) {
            $response->setContent($this->generateUrl('fos_user_security_login'));
        } else {

            $em = $this->getDoctrine()->getManager();

            $user = $this->getCurrentUser();
            if ($playList->getUser()->getId() != $user->getId()) {
                $this->get('session')->getFlashBag()->add(
                    'error',
                    'playlist.you_dont_have_permission'
                );
                $response->setContent($this->generateUrl('playlist_list'));
            } else {
                $em->remove($playList);
                $em->flush();

                $this->get('session')->getFlashBag()->add(
                    'success',
                    'playlist.successful_deleted'
                );
                $response->setContent($this->generateUrl('playlist_list'));
            }
        }
        return $response;
    }
}
