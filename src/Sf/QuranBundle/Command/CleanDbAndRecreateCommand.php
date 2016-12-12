<?php
namespace Sf\QuranBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Application;
use Symfony\Component\Console\Input\ArrayInput;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\HttpKernel\KernelInterface;

class cleanDbAndRecreateCommand extends ContainerAwareCommand
{

    protected function configure()
    {
        $this
            ->setName('quran:cleanandcreate')
            ->setDescription("Clean and recreate database.");
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     * @return int|null|void
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $kernel = $this->getContainer()->get('kernel');
        $env = $input->getOption("env");
        $pdo = $this->getContainer()->get('doctrine.dbal.default_connection')->getWrappedConnection();
        $dir = $this->getContainer()->getParameter('kernel.root_dir') . '/sql/';

        //beware this method will destroy your database!!!
        $this->dropAndRecreateSchema($kernel, $output, $env);

        //list app/sql folder
        $commands = $this->readSqlsFolder($dir);

        if (count($commands) > 0) {

            foreach ($commands as $command) {
                try {
                    $statment = $pdo->prepare($command);
                    $statment->execute();
                    $output->writeln(sprintf("<info>%s</info>", $command));
                } catch (\PDOException $e) {
                    $output->writeln(sprintf("<error>%s</error>", $command));
                    $output->writeln(sprintf("<error>%s</error>", $e->getMessage()));
                }
                $output->writeln('---------------------------------------------');
            }
        }

    }

    /**
     * @param $dir
     * @return array
     */
    private function readSqlsFolder($dir)
    {
        $commands = [];

        if ($handle = opendir($dir)) {

            while (false !== ($entry = readdir($handle))) {

                if ($entry != "." && $entry != "..") {

                    $commands[] = file_get_contents($dir . $entry);
                }
            }

            closedir($handle);
        }

        return $commands;
    }

    /**
     * @param KernelInterface $kernel
     * @param OutputInterface $output
     * @param string $env
     */
    private function dropAndRecreateSchema(KernelInterface $kernel, OutputInterface $output, $env = "dev")
    {
        $application = new Application($kernel);
        $application->setAutoExit(false);

        $input = new ArrayInput(array(
            'command' => 'doctrine:database:drop',
            '--force' => true,
            '--no-interaction' => true,
            '--env' => $env,
        ));
        $application->run($input, $output);

        $input = new ArrayInput(array(
            'command' => 'doctrine:database:create',
            '--no-interaction' => true,
            '--env' => $env,
        ));
        $application->run($input, $output);

        $input = new ArrayInput(array(
            'command' => 'doctrine:schema:create',
            '--no-interaction' => true,
            '--env' => $env,
        ));
        $application->run($input, $output);
    }
}