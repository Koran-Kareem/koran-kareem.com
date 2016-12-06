<?php

namespace Sf\QuranBundle\Controller;

use Sf\CoreBundle\Controller\CoreController as Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;

class DefaultController extends Controller
{
    /**
     * @Template()
     */
    public function indexAction()
    {
        $response = $this->render('QuranBundle:Default:index.html.twig', array());
        $response->setMaxAge(600);
        $response->setPublic();
        return $response;

    }

    /**
     * @Template()
     */
    public function chapterListAction()
    {
        $rChapterList = $this->getRepository('QuranBundle:Chapter');
        $chapterList = $rChapterList->findAll();
        return array('chapterList' => $chapterList);
    }
}
