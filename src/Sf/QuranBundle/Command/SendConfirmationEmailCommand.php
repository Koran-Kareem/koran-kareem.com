<?php
namespace Sf\QuranBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\HttpFoundation\Response;

class SendConfirmationEmailCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            ->setName('quran:send:email-confirmation')
            ->setDescription('Send email confirmation to unconfirmed users');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output->writeln('<info>Getting all unconfirmed users</info>');
        /** @var $entityManager \Doctrine\ORM\EntityManager */
        $entityManager = $this->getContainer()->get('doctrine')->getEntityManager();
        $rUsers = $entityManager->getRepository('UserBundle:User');

        $usersList = $rUsers->findBy([
            'enabled' => 0
        ], [], 100);

        //Setting the local to AR
        $this->getContainer()->get('translator')->setLocale('ar');
        $output->writeln('<info>Users count: ' . count($usersList) . '</info>');

        foreach ($usersList as $user) {
            $this->getContainer()->get('fos_user.mailer')->sendConfirmationEmailMessage($user);
        }
        $output->writeln('<info>Done !</info>');
    }

}
