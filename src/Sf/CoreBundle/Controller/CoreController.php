<?php

namespace Sf\CoreBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Component\DependencyInjection\ContainerInterface;

class CoreController extends Controller
{
    /**
     * @return Boolean
     */
    public function checkIfAuthenticated()
    {
        $securityContext = $this->get('security.context');
        if (!$securityContext->isGranted('IS_AUTHENTICATED_REMEMBERED')) {
            $this->get('session')->getFlashBag()->add(
                'error',
                'playlist.not_authenticated'
            );
            return false;
        }
        return true;
    }

    /**
     * @return \Symfony\Component\HttpFoundation\RedirectResponse
     */
    public function redirectToLogin()
    {
       return $this->redirect($this->generateUrl('fos_user_security_login'));
    }

    /**
     * @return \Sf\UserBundle\Entity\User
     */
    public function getCurrentUser(){
        return $this->get('security.context')->getToken()->getUser();
    }


    /**
     * @param $repositoryName
     * @return \Doctrine\Common\Persistence\ObjectRepository
     */
    protected function getRepository($repositoryName)
    {
        return $this->getDoctrine()->getManager()->getRepository($repositoryName);
    }
}
