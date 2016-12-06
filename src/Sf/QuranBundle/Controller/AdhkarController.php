<?php

namespace Sf\QuranBundle\Controller;

use Sf\CoreBundle\Controller\CoreController as Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Sf\QuranBundle\Entity\Adhkar;

class AdhkarController extends Controller
{
    /**
     * @Template()
     */
    public function playAllAction()
    {
        $rAdhkar = $this->getRepository('QuranBundle:Adhkar');
        $adhkarList = $rAdhkar->findAll();
        return array('adhkarList' => $adhkarList);
    }

    /**
     * @Template()
     */
    public function listAction()
    {
        $rAdhkar = $this->getRepository('QuranBundle:Adhkar');
        $adhkarList = $rAdhkar->findAll();
        return array('adhkarList' => $adhkarList);
    }

    /**
     * @Template()
     */
    public function adhkarBlockAction()
    {
        $rAdhkar = $this->getRepository('QuranBundle:Adhkar');
        $adhkarList = $rAdhkar->getRandom(9);
        return array('adhkarList' => $adhkarList);
    }

    /**
     * @Template()
     */
    public function playAction(Adhkar $adhkar)
    {
        if(!$adhkar){
            throw new \Symfony\Component\HttpKernel\Exception\NotFoundHttpException();
        }
        return array('adhkar' => $adhkar);
    }
}
