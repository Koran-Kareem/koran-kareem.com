<?php

namespace Sf\CoreBundle\Controller;

use Sf\CoreBundle\Controller\CoreController as Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Sf\CoreBundle\Entity\Contact;
use Sf\CoreBundle\Form\ContactType;

class ContactController extends Controller
{
    /**
     * @Template()
     */
    public function contactAction()
    {
        $contact = new Contact();
        $form = $this->createForm(new ContactType(), $contact);

        $request = $this->getRequest();
        if ($request->getMethod() == 'POST') {
            $form->bind($request);

            if ($form->isValid()) {
                $em = $this->getDoctrine()->getManager();
                $em->persist($contact);
                $em->flush();
                $thxMessage = $this->get('translator')->trans('global.thanks_contact_us');
                $this->get('session')->getFlashBag()->add(
                    'success',
                    $thxMessage
                );
                $toName = $this->getParameter('webmaster_name');
                $toEmail = $this->getParameter('webmaster_email');
                $message = \Swift_Message::newInstance()
                    ->setSubject($toName . ' Contact')
                    ->setFrom($toEmail)
                    ->setTo($toEmail)
                    ->setContentType('text/html')
                    ->setBody(
                        $this->renderView(
                            'CoreBundle:Contact:email.html.twig',
                            array(
                                'name' => $contact->getName(),
                                'email' => $contact->getEmail(),
                                'subject' => $contact->getSubject(),
                                'body' => $contact->getBody(),
                            )
                        )
                    )
                ;
                $this->get('mailer')->send($message);
                return $this->redirect($this->generateUrl('core_contact_us'));
            }
        }

        return array(
            'form' => $form->createView()
        );
    }
}
