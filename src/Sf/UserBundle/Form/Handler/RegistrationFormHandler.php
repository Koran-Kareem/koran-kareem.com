<?php

/*
 * This file is part of the FOSUserBundle package.
 *
 * (c) FriendsOfSymfony <http://friendsofsymfony.github.com/>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Sf\UserBundle\Form\Handler;

use FOS\UserBundle\Model\UserManagerInterface;
use FOS\UserBundle\Mailer\MailerInterface;
use FOS\UserBundle\Util\TokenGeneratorInterface;
use Symfony\Component\Form\FormInterface;
use Symfony\Component\HttpFoundation\Request;
use Sf\UserBundle\Entity\User;
use FOS\UserBundle\Model\UserInterface;

class RegistrationFormHandler
{


    public function __construct(FormInterface $form, Request $request, UserManagerInterface $userManager, MailerInterface $mailer, TokenGeneratorInterface $tokenGenerator)
    {
        $this->form = $form;
        $this->request = $request;
        $this->userManager= $userManager;
        $this->mailer = $mailer;
        $this->tokenGenerator = $tokenGenerator;
    }

    /**
     * @param boolean $confirmation
     */
    public function process($confirmation = false,$user)
    {
        $this->form->setData($user);
        $this->form->bind($this->request);
        $user->setUsername($user->getEmail());

        if ($this->form->isValid()) {
            $this->onSuccess($user, $confirmation);

            return true;
        }

        return false;
    }

    /**
     * @param boolean $confirmation
     */
    protected function onSuccess(UserInterface $user, $confirmation)
    {
        if ($confirmation) {
            $user->setEnabled(false);
            if (null === $user->getConfirmationToken()) {
                $user->setConfirmationToken($this->tokenGenerator->generateToken());
            }

            $this->mailer->sendConfirmationEmailMessage($user);
        } else {
            $user->setEnabled(true);
        }

        $this->userManager->updateUser($user);
    }

}
