<?php

namespace Sf\QuranBundle\DataFixtures\ORM;

use Doctrine\Common\DataFixtures\FixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Sf\QuranBundle\Entity\QuranReciter;

class LoadQuranReciterData implements FixtureInterface
{
    /**
     * {@inheritDoc}
     */
    public function load(ObjectManager $manager)
    {
        $arrayReciter = array(
            'Ahmed Ajmi' => ' أحمد بن علي العجمي',
            'Abdulbasit' => 'عبد الباسط عبد الصمد',
            'Al Afasi' => 'مشاري العفاسي',
            'Al Ghamdi' => 'سعد الغامدي',
            'Al Hussary' => 'محمود خليل الحصري',
            'Ali Al huthaifi' => 'علي الحذيفي',
            'Al Lohaidan' => 'محمد اللحيدان',
            'Al Minshawi' => 'محمد صديق المنشاوي',
            'Al Qahtani' => 'خالد القحطاني',
            'Al Shuraim' => 'سعود الشريم',
            'Al Sudays' => 'عبدالرحمن السديس',
            'Mohamed Ayub' => 'محمد أيوب',
            'Fares Abed' => 'فارس عباد',
            'Hani Rifai' => 'هاني الرفاعي',
            'Ali Jaber' => 'علي جابر',
            'Maher Al Muaiqly' => 'ماهر المعيقلي',
            'Mahmoud Al Refaae' => 'محمود الرفاعي',
            'Mustafa Ismail' => 'مصطفى إسماعيل',
            'Abu Bakr Al Shatri' => 'شيخ أبو بكر الشاطري',
            'Yasser Al Dosari' => 'ياسر الدوسري',
            'Zain Mohamed Ahmed' => 'الزين محمد أحمد',
            'Ali Al Barrak' => 'علي البراق',
        );
        foreach ($arrayReciter as $name => $arabicName) {
            $reciter = new QuranReciter();
            $reciter->setName($name);
            $reciter->setArabicName($arabicName);
            $reciter->setActive(true);
            $manager->persist($reciter);
        }

        $manager->flush();
    }
}
