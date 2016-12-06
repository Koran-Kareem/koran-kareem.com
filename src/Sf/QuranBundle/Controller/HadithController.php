<?php

namespace Sf\QuranBundle\Controller;

use Sf\CoreBundle\Controller\CoreController as Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sf\QuranBundle\Entity\HadithCategory;
use Sf\QuranBundle\Entity\Hadith;

class HadithController extends Controller
{
    /**
     * @Template()
     */
    public function categoriesAction()
    {
        $rCategoryList = $this->getRepository('QuranBundle:HadithCategory');
        $categoriesList = $rCategoryList->findAll();

        return array('categoriesList' => $categoriesList);
    }

    /**
     * @Template()
     */
    public function categoryAction(HadithCategory $hadithCategory)
    {
        if (!$hadithCategory) {
            throw new \Symfony\Component\HttpKernel\Exception\NotFoundHttpException();
        }
        $rHadithList = $this->getRepository('QuranBundle:Hadith');
        $hadithList = $rHadithList->findBy(array('category' => $hadithCategory));

        return array('category' => $hadithCategory, 'hadithList' => $hadithList);
    }

    /**
     * @Template()
     * @ParamConverter("hadithCategory", class="QuranBundle:HadithCategory", options={"id" = "category_id"})
     */
    public function playAction(Hadith $hadith, HadithCategory $hadithCategory)
    {
        if (!$hadith && !$hadithCategory) {
            throw new \Symfony\Component\HttpKernel\Exception\NotFoundHttpException();
        }
        return array('hadith' => $hadith, 'category' => $hadithCategory);
    }

    /**
     * @Template()
     */
    public function playAllAction(HadithCategory $hadithCategory)
    {
        if (!$hadithCategory) {
            throw new \Symfony\Component\HttpKernel\Exception\NotFoundHttpException();
        }
        $rHadithList = $this->getRepository('QuranBundle:Hadith');
        $hadithList = $rHadithList->findBy(array('category' => $hadithCategory));

        return array('hadithList' => $hadithList,'category'=>$hadithCategory);
    }

}
