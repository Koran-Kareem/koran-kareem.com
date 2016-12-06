<?php

namespace Sf\UserBundle\Controller;

use FOS\UserBundle\Controller\RegistrationController as BaseController;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Sf\UserBundle\Form\Type\RegistrationFormType;
use Symfony\Component\HttpFoundation\Request;
use Sf\UserBundle\Entity\User;
use Sf\UserBundle\Form\Handler\RegistrationFormHandler;
use Symfony\Component\HttpFoundation\RedirectResponse;

class RegistrationController extends BaseController
{
    public function registerAction()
    {
        $request = $this->container->get('request');
        $user = new User();
        $form = $this->container->get('form.factory')->create(new RegistrationFormType('Sf\UserBundle\Entity\User'), $user);

        if ('POST' === $this->container->get('request')->getMethod()) {
            $formHandler = new RegistrationFormHandler($form, $this->container->get('request'), $this->container->get('fos_user.user_manager'), $this->container->get('fos_user.mailer'), $this->container->get('fos_user.util.token_generator'));
            $userData = $request->request->get('sf_user_registration');
            $userEmail = $userData['email'];
            $userExist = $this->container->get('fos_user.user_manager')->findUserByEmail($userEmail);
            if ($userExist) {
                $this->setFlash('error', 'registration.flash.already_used');
                $user->setEmail($userEmail);
                $form->setData($user);
            } else {
                $confirmationEnabled = $this->container->getParameter('fos_user.registration.confirmation.enabled');
                $process = $formHandler->process($confirmationEnabled, $user);
                if ($process) {
                    $user = $form->getData();
                    $authUser = false;
                    if ($confirmationEnabled) {
                        $this->container->get('session')->set('fos_user_send_confirmation_email/email', $user->getEmail());
                        $route = 'fos_user_registration_check_email';
                    } else {
                        $authUser = true;
                        $route = 'fos_user_registration_confirmed';
                    }

                    $this->setFlash('success', 'registration.flash.user_created');
                    $url = $this->container->get('router')->generate($route);
                    $response = new RedirectResponse($url);

                    if ($authUser) {
                        $this->authenticateUser($user, $response);
                    }
                    return $response;
                }
            }
        }
        return $this->container->get('templating')->renderResponse('FOSUserBundle:Registration:register.html.' . $this->getEngine(), array(
                'form' => $form->createView(),
            ));
    }

    /**
     * @param string $action
     * @param string $value
     */
    protected function setFlash($action, $value)
    {
        $this->container->get('session')->getFlashBag()->add($action, $value);
    }
}
