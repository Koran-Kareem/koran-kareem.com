<?php

namespace Sf\QuranBundle\Controller;

use Sf\CoreBundle\Controller\CoreController as Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Sf\QuranBundle\Entity\QuranReciter;
use Symfony\Component\HttpFoundation\BinaryFileResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;

class ReciterController extends Controller
{
    /**
     * @Template()
     */
    public function recitersListAction()
    {
        $rReciters = $this->getRepository('QuranBundle:QuranReciter');
        $recitersList = $rReciters->findAll();
        return array('recitersList' => $recitersList);
    }

    /**
     * @Template()
     */
    public function recitersListBlockAction()
    {
        $rReciters = $this->getRepository('QuranBundle:QuranReciter');
        $recitersList = $rReciters->getRandom();
        return array('recitersList' => $recitersList);
    }

    /**
     * @Template()
     */
    public function reciterAction($slug, $name)
    {
        $rReciter = $this->getRepository('QuranBundle:QuranReciter');
        $reciter = $rReciter->findOneBy(array('slug' => $slug));
        if(!$reciter){
            throw new \Symfony\Component\HttpKernel\Exception\NotFoundHttpException();
        }
        $rChapterList = $this->getRepository('QuranBundle:Chapter');
        $chapterList = $rChapterList->findAll();
        return array('chapterList' => $chapterList, 'reciter' => $reciter);
    }

    /**
     * @Template()
     */
    public function chapterAction($slug, $name)
    {
        $rReciter = $this->getRepository('QuranBundle:QuranReciter');
        $reciter = $rReciter->findOneBy(array('slug' => $slug));
        if(!$reciter){
            throw new \Symfony\Component\HttpKernel\Exception\NotFoundHttpException();
        }
        $rChapterList = $this->getRepository('QuranBundle:Chapter');
        $chapterList = $rChapterList->findAll();
        return array('chapterList' => $chapterList, 'reciter' => $reciter);
    }


    /**
     * @Template()
     */
    public function playAction($slug, $name,$chapter,$ordering)
    {
        $rReciter = $this->getRepository('QuranBundle:QuranReciter');
        $reciter = $rReciter->findOneBy(array('slug' => $slug));
        if(!$reciter){
            throw new \Symfony\Component\HttpKernel\Exception\NotFoundHttpException();
        }

        return array('ordering' => $ordering, 'reciter' => $reciter,'chapter' =>$chapter);
    }

    /**
     */
    public function downloadAction($slug, $ordering)
    {
        $rReciter = $this->getRepository('QuranBundle:QuranReciter');
        $reciter = $rReciter->findOneBy(array('slug' => $slug));
        if(!$reciter){
            throw new \Symfony\Component\HttpKernel\Exception\NotFoundHttpException();
        }

        $path = $this->get('kernel')->getRootDir(). '/../web';
        $file = '/upload/Quran_Reciter/'.$slug.'/'.$ordering.'.mp3';

        $response = new BinaryFileResponse($path.$file);
        $response->headers->set('Content-Type', 'text/plain');
        $response->setContentDisposition(
            ResponseHeaderBag::DISPOSITION_ATTACHMENT,
            'koran-kareem.com_'.$slug.'_'.$ordering.'.mp3'
        );
        return $response;
    }
}
