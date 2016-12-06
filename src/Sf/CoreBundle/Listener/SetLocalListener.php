<?php
namespace Sf\CoreBundle\Listener;

use Symfony\Component\HttpKernel\Event\GetResponseEvent;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\HttpExceptionInterface;
use Symfony\Component\Security\Core\SecurityContext;

class SetLocalListener
{
    public function onKernelRequest(GetResponseEvent $event)
    {
        //if you are passing through any data
        $request = $event->getRequest();
        $request->setLocale("ar");

    }
}