<?php
namespace Sf\AdminBundle\Controller;

use Sonata\AdminBundle\Admin\Admin;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Validator\ErrorElement;
use Sonata\AdminBundle\Form\FormMapper;
use Symfony\Component\Translation\TranslatorInterface;

class QuranReciterAdminController extends Admin
{
    protected function configureFormFields(FormMapper $formMapper)
    {
        $formMapper
            ->add('name')
            ->add('arabicName', null, array('attr' => array('style' => 'direction:rtl')))
            ->add('country')
            ->add('history', null, array('attr' => array('style' => 'direction: rtl; width: 545px; height: 146px;')))
            ->add('slug', null, array('required' => false))
            ->add('active', null, array('required' => false));
    }

    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper
            ->add('name')
            ->add('country')
            ->add('arabicName');
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->addIdentifier('arabicName')
            ->add('country')
            ->add('slug')
            ->add('active');
    }


}