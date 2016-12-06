<?php

namespace Sf\QuranBundle\Controller;

use Sf\CoreBundle\Controller\CoreController as Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Sf\QuranBundle\Entity\Tilawa;

class TilawaController extends Controller
{
    /**
     * @Template()
     */
    public function playAllAction()
    {
        $rTilawa = $this->getRepository('QuranBundle:Tilawa');
        $tilawaList = $rTilawa->findAll();
        return array('tilawaList' => $tilawaList);
    }

    /**
     * @Template()
     */
    public function listAction()
    {
        $rTilawa = $this->getRepository('QuranBundle:Tilawa');
        $tilawaList = $rTilawa->findAll();
        return array('tilawaList' => $tilawaList);
    }

    /**
     * @Template()
     */
    public function tilawaBlockAction()
    {
        $rTilawa = $this->getRepository('QuranBundle:Tilawa');
        $tilawaList = $rTilawa->getRandom();
        return array('tilawaList' => $tilawaList);
    }

    /**
     * @Template()
     */
    public function playAction(Tilawa $tilawa)
    {
        if(!$tilawa){
            throw new \Symfony\Component\HttpKernel\Exception\NotFoundHttpException();
        }
        return array('tilawa' => $tilawa);
    }
}
