<?php

namespace Sf\CoreBundle\Twig;

use Sf\QuranBundle\Entity\Adhkar;
use Sf\QuranBundle\Entity\Tilawa;
use Sf\QuranBundle\Entity\QuranReciter;
use Sf\QuranBundle\Entity\Hadith;
use Sf\QuranBundle\Entity\HadithCategory;
use Sf\QuranBundle\Entity\TextAdhkarCategory;
use Doctrine\Common\Collections\ArrayCollection;

class CoreExtension extends \Twig_Extension
{

    private $translator;
    private $em;

    public function __construct($translator, \Doctrine\ORM\EntityManager $em)
    {
        $this->translator = $translator;
        $this->em = $em;
    }

    /**
     * {@inheritdoc}
     */
    public function getFunctions()
    {
        return array(
            'generate_player_reciter' => new \Twig_Function_Method($this, 'generatePlayerReciter'),
            'generate_player_adhkar'  => new \Twig_Function_Method($this, 'generatePlaylistAdhkar'),
            'generate_player_tilawa'  => new \Twig_Function_Method($this, 'generatePlaylistTilawa'),
            'generate_player_chapter' => new \Twig_Function_Method($this, 'generatePlaylistChapter'),
            'generate_player_hadith'  => new \Twig_Function_Method($this, 'generatePlaylistHadith'),
            'generate_home_player'    => new \Twig_Function_Method($this, 'generatePlaylistHome'),
            'generate_playlist'       => new \Twig_Function_Method($this, 'generatePlaylist'),
            'generate_meta'           => new \Twig_Function_Method($this, 'generateMeta'),
        );
    }

    /**
     * {@inheritdoc}
     */
    public function getFilters()
    {
        return array(
            'url_decode' => new \Twig_Filter_Method($this, 'urlDecode')
        );
    }

    /**
     * @param string $reciterDir
     * @param string $adhkarDir
     * @param string $tilawaDir
     * @param string $hadithDir
     * @return
     */
    public function generatePlaylistHome($reciterDir, $adhkarDir, $tilawaDir, $hadithDir)
    {
        $typeAudioFile = $this->translator->trans('global.audiofile');
        $hadith_play = $this->translator->trans('global.hadith_play');
        $rChapterList = $this->em->getRepository('QuranBundle:Chapter');
        $rReciter = $this->em->getRepository('QuranBundle:QuranReciter');
        $rAdhkar = $this->em->getRepository('QuranBundle:Adhkar');
        $rHadith = $this->em->getRepository('QuranBundle:Hadith');
        $chapterList = $rChapterList->findAll();

        $html = $this->startPlayerHtml();

        $isFriday = date('N') == 5;
        /**
         * If is Friday so we show random Reciters with Chapter `Alkahf - `
         */
        if ($isFriday) {
            $reciterList = $rReciter->getRandom(20);
            foreach ($reciterList as $reciter) {
                $chapter = $chapterList[17];
                $chapterPath = "/" . $reciterDir . "/" . $reciter->getSlug() . "/" . $chapter->getOrdering() . ".mp3";
                if (file_exists("../web" . $chapterPath)) {
                    $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $chapterPath . "' data-title='" . $chapter->getName() . " - " . $reciter->getArabicName() . "' >
                    <a class='playlistNonSelected' href='#'>" . $chapter->getName() . " - " . $reciter->getArabicName() . "</a>
                    </li>";
                }
            }
            $audioList = $reciterList;
        } else {
            $reciterList = $rReciter->getRandom(10);
            $adhkarList = $rAdhkar->getRandom(10);
            $hadithList = $rHadith->getRandom(10);
            $audioList = array_merge((array)$adhkarList, (array)$reciterList, (array)$hadithList);
            shuffle($audioList);
            $audioList = new ArrayCollection($audioList);

            foreach ($audioList as $audio) {
                switch (get_class($audio)) {
                    case 'Sf\QuranBundle\Entity\QuranReciter':
                        $reciter = $audio;
                        $rand = rand(0, 113);
                        $chapter = $chapterList[$rand];
                        $chapterPath = "/" . $reciterDir . "/" . $reciter->getSlug() . "/" . $chapter->getOrdering() . ".mp3";
                        if (file_exists("../web" . $chapterPath)) {
                            $html .= "<li class='playlistItem' data-type='local' data-mp3='" . $chapterPath . "' data-title='" . $chapter->getName() . " - " . $reciter->getArabicName() . "' >
                            <a class='playlistNonSelected' href='#'>" . $chapter->getName() . " - " . $reciter->getArabicName() . "</a>
                            </li>";
                        }
                        break;
                    case 'Sf\QuranBundle\Entity\Adhkar':
                        $adhkar = $audio;
                        $adhkarPath = "/" . $adhkarDir . "/" . $adhkar->getOrdering() . ".mp3";
                        if (file_exists("../web" . $adhkarPath)) {
                            $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $adhkarPath . "' data-title='" . $adhkar->getName() . " - " . $adhkar->getReciter() . "' >
                            <a class='playlistNonSelected' href='#'>" . $adhkar->getName() . " - " . $adhkar->getReciter() . "</a>
                            </li>";
                        }
                        break;
                    case 'Sf\QuranBundle\Entity\Hadith':
                        $hadith = $audio;
                        $hadithPath = "/" . $hadithDir . "/" . $hadith->getCategory()
                                                                      ->getId() . "/" . $hadith->getOrdering() . ".mp3";
                        if (file_exists("../web" . $hadithPath)) {
                            $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $hadithPath . "' data-title='" . $hadith->getName() . " - " . $hadith_play . "'  >
                            <a class='playlistNonSelected' href='#'>" . $hadith->getName() . " - " . $hadith_play . "</a>
                            </li>";
                        }
                        break;
                }

            }
        }

        $html .= $this->endPlayerHtml(count($audioList) . ' ' . $typeAudioFile);

        return $html;
    }

    /**
     * @param array $chapterList
     * @param \Sf\QuranBundle\Entity\QuranReciter $reciter
     * @param string $reciterDir
     * @return
     */
    public function generatePlayerReciter($chapterList, $reciter, $reciterDir)
    {
        $typeAudioFile = $this->translator->trans('global.chapter');
        $html = $this->startPlayerHtml();
        foreach ($chapterList as $chapter) {
            $chapterPath = "/" . $reciterDir . "/" . $reciter->getSlug() . "/" . $chapter->getOrdering() . ".mp3";
            if (file_exists("../web" . $chapterPath)) {
                $html .= "<li class='playlistItem' data-type='local' data-mp3='" . $chapterPath . "' data-title='" . $chapter->getName() . " - " . $reciter->getArabicName() . "' >
                            <a class='playlistNonSelected' href='#'>" . $chapter->getName() . " - " . $reciter->getArabicName() . "</a>
                            </li>";
            }
        }
        $html .= $this->endPlayerHtml(count($chapterList) . ' ' . $typeAudioFile);

        return $html;
    }


    /**
     * @param \Sf\QuranBundle\Entity\QuranReciter $reciter
     * @param $ordering $reciterDir
     * @param string $reciterDir
     * @return
     */
    public
    function generatePlaylistChapter(
        $reciter, $ordering, $chapter, $reciterDir
    ) {
        $typeAudioFile = $this->translator->trans('global.chapter');

        $html = $this->startPlayerHtml();
        $chapterPath = "/" . $reciterDir . "/" . $reciter->getSlug() . "/" . $ordering . ".mp3";
        if (file_exists("../web" . $chapterPath)) {
            $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $chapterPath . "' data-title='" . $chapter . " - " . $reciter->getArabicName() . "' >
            <a class='playlistNonSelected' href='#'>" . $chapter . " - '" . $reciter->getArabicName() . "</a>
            </li>";
        }
        $html .= $this->endPlayerHtml('1 '.$typeAudioFile);

        return $html;
    }

    /**
     * @param array $adhkarList
     * @param string $adhkarDir
     * @return
     */
    public
    function generatePlaylistAdhkar(
        $adhkarList, $adhkarDir
    ) {
        $typeAudioFile = $this->translator->trans('global.adhkars');

        $html = $this->startPlayerHtml();
        $count = 0;
        if (is_array($adhkarList)) {
            foreach ($adhkarList as $adhkar) {
                /** @var $adhkar  \Sf\QuranBundle\Entity\Adhkar */
                $adhkarPath = "/" . $adhkarDir . "/" . $adhkar->getOrdering() . ".mp3";
                if (file_exists("../web" . $adhkarPath)) {
                    $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $adhkarPath . "' data-title='" . $adhkar->getName() . " - " . $adhkar->getReciter() . "' >
                    <a class='playlistNonSelected' href='#'>" . $adhkar->getName() . " - " . $adhkar->getReciter() . "</a>
                    </li>";
                }
            }
            $count = count($adhkarList);
        } elseif ($adhkarList instanceof Adhkar) {
            $adhkar = $adhkarList;
            $adhkarPath = "/" . $adhkarDir . "/" . $adhkar->getOrdering() . ".mp3";
            if (file_exists("../web" . $adhkarPath)) {
                $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $adhkarPath . "' data-title='" . $adhkar->getName() . " - " . $adhkar->getReciter() . "' >
                <a class='playlistNonSelected' href='#'>" . $adhkar->getName() . " - " . $adhkar->getReciter() . "</a>
                </li>";
            }
            $count = 1;

        }
        $html .= $this->endPlayerHtml($count . ' ' . $typeAudioFile);

        return $html;
    }

    /**
     * @param array $hadithList
     * @param string $hadithDir
     * @return
     */
    public
    function generatePlaylistHadith(
        $hadithList, $hadithDir
    ) {
        $typeAudioFile = $this->translator->trans('main_menu.hadith');

        $html = $this->startPlayerHtml();
        $count = 0;
        if (is_array($hadithList)) {
            foreach ($hadithList as $hadith) {
                /** @var $hadith  \Sf\QuranBundle\Entity\Hadith */
                $hadithPath = "/" . $hadithDir . "/" . $hadith->getCategory()
                                                              ->getId() . "/" . $hadith->getOrdering() . ".mp3";
                if (file_exists("../web" . $hadithPath)) {
                    $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $hadithPath . "' data-title='" . $hadith->getName() . "' >
                    <a class='playlistNonSelected' href='#'>" . $hadith->getName() . "</a>
                    </li>";
                }
            }
            $count = count($hadithList);
        } elseif ($hadithList instanceof Hadith) {
            $hadith = $hadithList;
            $hadithPath = "/" . $hadithDir . "/" . $hadith->getCategory()
                                                          ->getId() . "/" . $hadith->getOrdering() . ".mp3";
            if (file_exists("../web" . $hadithPath)) {
                $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $hadithPath . "' data-title='" . $hadith->getName() . "' >
                <a class='playlistNonSelected' href='#'>" . $hadith->getName() . "</a>
                </li>";
            }
            $count = 1;

        }
        $html .= $this->endPlayerHtml($count . ' ' . $typeAudioFile);

        return $html;
    }

    /**
     * @param array $adhkarList
     * @param string $adhkarDir
     * @return
     */
    public
    function generatePlaylistTilawa(
        $tilawaList, $tilawaDir
    ) {
        $typeAudioFile = $this->translator->trans('global.tilawat');

        $html = $this->startPlayerHtml();
        $count = 0;
        if (is_array($tilawaList)) {
            foreach ($tilawaList as $tilawa) {
                /** @var $tilawa  \Sf\QuranBundle\Entity\Tilawa */
                $tilawaPath = "/" . $tilawaDir . "/" . $tilawa->getOrdering() . ".mp3";
                if (file_exists("../web" . $tilawaPath)) {
                    $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $tilawaPath . "' data-title='" . $tilawa->getName() . " - " . $tilawa->getName() . "' >
                    <a class='playlistNonSelected' href='#'>" . $tilawa->getName() . " - " . $tilawa->getName() . "</a>
                    </li>";
                }
            }

            $count = count($tilawaList);
        } elseif ($tilawaList instanceof Tilawa) {
            $tilawa = $tilawaList;
            /** @var $tilawa  \Sf\QuranBundle\Entity\Tilawa */
            $tilawaPath = "/" . $tilawaDir . "/" . $tilawa->getOrdering() . ".mp3";
            if (file_exists("../web" . $tilawaPath)) {
                $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $tilawaPath . "' data-title='" . $tilawa->getName() . " - " . $tilawa->getName() . "' >
                <a class='playlistNonSelected' href='#'>" . $tilawa->getName() . " - " . $tilawa->getName() . "</a>
                </li>";
            }
            $count = 1;

        }
        $html .= $this->endPlayerHtml($count . ' ' . $typeAudioFile);

        return $html;
    }

    /**
     * @param \Sf\QuranBundle\Entity\PlaylistItem $items
     * @param string $reciterDir
     * @return
     */
    public
    function generatePlaylist(
        $items, $reciterDir, $adhkarDir, $tilawaDir
    ) {
        $typeAudioFile = $this->translator->trans('global.items');

        $html = $this->startPlayerHtml();

        foreach ($items as $item) {
            /** @var $item \Sf\QuranBundle\Entity\PlaylistItem */
            $type = $item->getType();
            if ($type == "chapter") {
                $chapterPath = "/" . $reciterDir . "/" . $item->getReciter()->getSlug() . "/" . $item->getChapter()
                                                                                                     ->getOrdering() . ".mp3";
                if (file_exists("../web" . $chapterPath)) {
                    $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $chapterPath . "' data-title='" . $item->getChapter()
                                                                                                                               ->getName() . " - " . $item->getReciter()
                                                                                                                                                                 ->getArabicName() . "' >
                                                                                                                                                                   <a class='playlistNonSelected' href='#'>" . $item->getChapter()
                                                                                                                                                                                                                    ->getName() . " - " . $item->getReciter()
                                                                                                                                                                                                                                               ->getArabicName() . "</a>
                                                                                                                                                                   </li>";
                }
            } elseif ($type == "adhkar") {
                $adhkarPath = "/" . $adhkarDir . "/" . $item->getAdhkar()->getOrdering() . ".mp3";
                if (file_exists("../web" . $adhkarPath)) {
                    $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $adhkarPath . "' data-title='" . $item->getAdhkar()
                                                                                                                              ->getName() . " - " . $item->getAdhkar()
                                                                                                                                                                ->getReciter() . "' >
                                                                                                                                                                  <a class='playlistNonSelected' href='#'>" . $item->getAdhkar()
                                                                                                                                                                                                                   ->getName() . " - " . $item->getAdhkar()
                                                                                                                                                                                                                                              ->getReciter() . "</a>
                                                                                                                                                                  </li>";
                }
            } elseif ($type == "tilawa") {
                $tilawaPath = "/" . $tilawaDir . "/" . $item->getTilawa()->getOrdering() . ".mp3";
                if (file_exists("../web" . $tilawaPath)) {
                    $html .= "<li class='playlistItem'  data-type='local' data-mp3='" . $tilawaPath . "' data-title='" . $item->getTilawa()
                                                                                                                              ->getName() . " - " . $item->getTilawa()
                                                                                                                                                                ->getName() . "' >
                                                                                                                                                                  <a class='playlistNonSelected' href='#'>" . $item->getTilawa()
                                                                                                                                                                                                                   ->getName() . " - " . $item->getTilawa()
                                                                                                                                                                                                                                              ->getName() . "</a>
                                                                                                                                                                  </li>";
                }
            }
        }
        $count = count($items);
        $html .= $this->endPlayerHtml($count . ' ' . $typeAudioFile);

        return $html;
    }

    /**
     * URL Decode a string
     *
     * @param string $url
     *
     * @return string The decoded URL
     */
    public
    function urlDecode(
        $url
    ) {
        return urldecode($url);
    }

    /**
     * @param string $objectType
     * @param object $object
     * @return
     */
    public
    function generateMeta(
        $objectType = '', $object = null, $extra = null
    ) {
        $title = $this->translator->trans('global.site_title');
        $description = $this->translator->trans('global.short_description');

        switch ($objectType) {
            case "QuranReciter":
                $reciter = $this->translator->trans('global.reciter');
                /** @var $object  \Sf\QuranBundle\Entity\QuranReciter */
                if ($object instanceof QuranReciter) {
                    $title = $title . " : Quran Reciter : $reciter : " . $object->getArabicName() . " " . $object->getName();
                    $description = "Quran Reciter : $reciter : " . $object->getArabicName() . ($object->getHistory() == "" ? "" : " : " . $object->getHistory());
                }
                break;

            case "Chapter":
                $reciter = $this->translator->trans('global.reciter');
                /** @var $object  \Sf\QuranBundle\Entity\QuranReciter */
                if ($object instanceof QuranReciter) {
                    $title = $title . " : " . $object->getArabicName() . " : " . $extra;
                    $description = $object->getArabicName() . " : $extra" . ($object->getHistory() == "" ? "" : " : " . $object->getHistory());
                }
                break;

            case "Reciters":
                $reciters = $this->translator->trans('main_menu.reciters_list');
                $title = $title . " : Quran Reciters : $reciters";
                break;

            case "Adhkar":
                $adhkar = $this->translator->trans('global.adhkars');
                /** @var $object  \Sf\QuranBundle\Entity\Adhkar */
                if ($object instanceof Adhkar) {
                    $title = $title . " : Adhkar : $adhkar : " . $object->getName() . ($object->getReciter() == "" ? "" : " - " . $object->getReciter());
                    $description = "Adhkar : $adhkar : " . $object->getName() . ($object->getReciter() == "" ? "" : " - " . $object->getReciter());
                }
                break;

            case "Adhkars":
                $adhkars = $this->translator->trans('main_menu.adhkar_list');
                $title = $title . " : Adhkars : $adhkars";
                break;

            case "Tilawa":
                $tilawa = $this->translator->trans('global.tilawat');
                /** @var $object  \Sf\QuranBundle\Entity\Tilawa */
                if ($object instanceof Tilawa) {
                    $title = $title . " : Tilawa : $tilawa : " . $object->getName();
                    $description = "Tilawa : $tilawa : " . $object->getName();
                }
                break;

            case "Tilawat":
                $tilawat = $this->translator->trans('main_menu.tilawat');
                $title = $title . " : Tilawat : $tilawat";
                break;

            case "HadithCategory":
                $hadith = $this->translator->trans('main_menu.hadith');
                /** @var $object  \Sf\QuranBundle\Entity\HadithCategory */
                if ($object instanceof HadithCategory) {
                    $title = $title . " : Hadith : $hadith : " . $object->getName();
                    $description = "Hadith : $hadith : " . $object->getName() . ($object->getDescription() == "" ? "" : " - " . $object->getDescription());
                }
                break;

            case "textAdhkarCategory":
                $textAdhkar = $this->translator->trans('global.text_adhkar');
                /** @var $object  \Sf\QuranBundle\Entity\TextAdhkarCategory */
                if ($object instanceof TextAdhkarCategory) {
                    $title = $title . " : $textAdhkar : " . $object->getName();
                    $description = "$textAdhkar : " . $object->getName();
                }
                break;

            case "textAdhkar":
                $textAdhkar = $this->translator->trans('global.text_adhkar');
                $title = $title . " : $textAdhkar";
                $description = "$textAdhkar";
                break;

            case "Hadith":
                $hadith = $this->translator->trans('main_menu.hadith');
                /** @var $object  \Sf\QuranBundle\Entity\Hadith */
                if ($object instanceof Hadith) {
                    $title = $title . " : Hadith : $hadith : " . $object->getCategory()
                                                                        ->getName() . " - " . $object->getName();
                    $description = "Hadith : $hadith : " . $object->getCategory()
                                                                  ->getName() . " - " . $object->getName();
                }
                break;

            case "Hadiths":
                $hadith = $this->translator->trans('main_menu.hadith');
                $title = $title . " : Hadith : $hadith ";
                break;

            case "Contact":
                $contact_us = $this->translator->trans('global.contact_us');
                $title = $title . " : " . $contact_us;
                break;

            case "Login":
                $login = $this->translator->trans('global.login');
                $title = $title . " : " . $login;
                break;

            case "Register":
                $register = $this->translator->trans('global.register');
                $title = $title . " : " . $register;
                break;
        }
        $html = "<title>$title</title>
        <meta name='Description' content='$description'/>
        <meta property='og:title' content='$title'/>
        <meta property='og:description' content='$description'/>";

        return $html;
    }

    private function    startPlayerHtml()
    {
        $html = '<div id="componentWrapper">

       		 <div class="playerHolder">

            	  <!-- song name -->
                  <div class="player_mediaName_Mask">
                 	  <div class="player_mediaName"></div>
                  </div>

                  <!-- song time -->
                  <div class="player_mediaTime">
                  	  <div class="player_mediaTime_current">0:00</div><div class="player_mediaTime_total">0:00</div>
                  </div>

                  <div class="player_controls">
                  	  <!-- previous -->
                      <div class="controls_prev"><img src="/bundles/core/player/data/icons/set1/prev.png" alt="controls_prev" width="32" height="32"/></div>
                      <!-- pause/play -->
                      <div class="controls_toggle"><img src="/bundles/core/player/data/icons/set1/play.png" alt="controls_toggle" width="32" height="32"/></div>
                      <!-- next -->
                      <div class="controls_next"><img src="/bundles/core/player/data/icons/set1/next.png" alt="controls_next" width="32" height="32"/></div>

                 	  <!-- volume -->
                      <div class="player_volume"><img src="/bundles/core/player/data/icons/set1/volume.png" alt="player_volume" width="24" height="24"/></div>
                      <div class="volume_seekbar">
                         <div class="volume_bg"></div>
                         <div class="volume_level"></div>
                         <!-- volume tooltip -->
                  		 <div class="player_volume_tooltip"><p></p></div>
                      </div>

                  <!-- loop -->
                      <div class="player_loop"><img src="/bundles/core/player/data/icons/set1/loop.png" alt="player_loop" width="24" height="24"/></div>
                      <!-- shuffle -->
                      <div class="player_shuffle"><img src="/bundles/core/player/data/icons/set1/shuffle.png" alt="player_shuffle" width="20" height="20"/></div>
                      <!-- download -->
                      <div class="player_download"><img src="/bundles/core/player/data/icons/set1/download.png" alt="player_download" width="25" height="26"/></div>
                  </div>

                  <!-- progress -->
                  <div class="player_progress">
                      <div class="progress_bg"></div>
                      <div class="load_progress"></div>
                      <div class="play_progress"></div>
                      <!-- progress tooltip -->
                  	  <div class="player_progress_tooltip"><p></p></div>
                  </div>

             </div>

             <div class="playlistHolder">
                 <div class="componentPlaylist">
                     <div class="playlist_inner">
                     	<!-- playlist items are appended here! -->
                     </div>
                 </div>
                 <!-- preloader -->
                 <div class="preloader"></div>
             </div>

        </div>
        <div id="playlist_list">

             <!-- local playlist -->
             <ul id="playlist1">';

        return $html;
    }

    private function endPlayerHtml($title = null)
    {
        $html = "</ul>
            </div>";
        if ($title) {
            $html .= '
            <div class="player-bottom">' . $title . '</div>';
        }

        return $html;
    }

    /**
     * {@inheritdoc}
     */
    public
    function getName()
    {
        return 'sf_core';
    }
}
