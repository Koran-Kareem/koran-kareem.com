<?php
namespace Sf\QuranBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\HttpFoundation\Response;

class SitemapCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            ->setName('quran:sitemap:generate')
            ->setDescription('Genarate Sitemap file');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output->writeln('<info>Start generating Sitemap.xml</info>');
        /** @var $entityManager \Doctrine\ORM\EntityManager */
        $entityManager = $this->getContainer()->get('doctrine')->getEntityManager();
        $site_url = $this->getContainer()->getParameter('site_url');
        /*
         * Generate Reciters and Chapter links
         * */
        $rReciters = $entityManager->getRepository('QuranBundle:QuranReciter');
        $rChapter = $entityManager->getRepository('QuranBundle:Chapter');
        $reciters = $rReciters->findAll();
        $chapters = $rChapter->findAll();

        /*
         * Generate Adhkars links
         * */
        $rAdhkars = $entityManager->getRepository('QuranBundle:Adhkar');
        $adhkars = $rAdhkars->findAll();

        /*
        * Generate Tilawat links
        * */
        $rTilawat = $entityManager->getRepository('QuranBundle:Tilawa');
        $tilawat = $rTilawat->findAll();

        /*
        * Generate Hadith links
        * */
        $rHadiths = $entityManager->getRepository('QuranBundle:Hadith');
        $rHadithsCategory = $entityManager->getRepository('QuranBundle:HadithCategory');
        $hadithsCategory = $rHadithsCategory->findAll();
        $hadiths = $rHadiths->findAll();

        /*
        * Generate Text Adhkar Category links
        * */
        $rTextAdhkar = $entityManager->getRepository('QuranBundle:TextAdhkarCategory');
        $textAdhkarCategory = $rTextAdhkar->findAll();


        $response = $this->getContainer()->get('templating')->renderResponse('QuranBundle:Sitemap:sitemap.xml.twig',
            array(
                'site_url' => $site_url,
                'reciters' => $reciters,
                'chapters' => $chapters,
                'adhkars' => $adhkars,
                'tilawat' => $tilawat,
                'hadithsCategory' => $hadithsCategory,
                'textAdhkarCategory' => $textAdhkarCategory,
                'hadiths' => $hadiths,
            )
        );
        /** @var $response \Symfony\Component\HttpFoundation\Response */
        $content = $response->getContent();
        $f = fopen('web/sitemap.xml', "w+");
        fwrite($f, $content);
        fclose($f);

        $output->writeln('<info>Finish</info>');
    }

}