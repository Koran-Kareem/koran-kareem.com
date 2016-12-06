<?php

namespace Sf\QuranBundle\Controller;

use Sf\CoreBundle\Controller\CoreController as Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sf\QuranBundle\Entity\TextAdhkarCategory;
use Sf\QuranBundle\Entity\TextAdhkar;

class TextAdhkarController extends Controller
{
    /**
     * @Template()
     */
    public function categoriesAction()
    {
        $rCategoryList = $this->getRepository('QuranBundle:TextAdhkarCategory');
        $categoriesList = $rCategoryList->findAll();

        return array('categoriesList' => $categoriesList);
    }

    /**
     * @Template()
     */
    public function textAdhkarAction(TextAdhkarCategory $adhkarCategory)
    {
        if (!$adhkarCategory) {
            throw new \Symfony\Component\HttpKernel\Exception\NotFoundHttpException();
        }
        $rAdhkarList = $this->getRepository('QuranBundle:TextAdhkar');
        $adhkarList = $rAdhkarList ->findBy(array('category' => $adhkarCategory));

        return array('category' => $adhkarCategory, 'textAdhkarList' => $adhkarList);
    }


}
