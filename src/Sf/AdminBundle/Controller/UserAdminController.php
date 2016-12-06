<?php
namespace Sf\AdminBundle\Controller;

use Sonata\AdminBundle\Admin\Admin;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Validator\ErrorElement;
use Sonata\AdminBundle\Form\FormMapper;
use Symfony\Component\Translation\TranslatorInterface;

class UserAdminController extends Admin
{
    protected function configureFormFields(FormMapper $formMapper)
    {
        $formMapper
            ->add('email')
            ->add('enabled', 'choice', array(
            'choices' => array(
                '0' => 'No',
                '1' => 'Yes',
            ),
            'expanded' => true,
            'multiple' => false,
        ));
    }

    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper
            ->add('email');
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->add('id')
            ->addIdentifier('username')
            ->add('enabled');

    }

    public function prePersist($object)
    {
        $object->setUsername($object->getEmail());
        parent::prePersist($object);
    }

    public function preUpdate($object)
    {
        $object->setUsername($object->getEmail());
        parent::prePersist($object);
    }


}