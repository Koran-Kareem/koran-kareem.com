<?php

namespace Sf\CoreBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class ContactType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name','text',array('label' => 'contact.label.name'))
            ->add('email','email',array('label' => 'contact.label.email'))
            ->add('subject','text',array('label' => 'contact.label.subject'))
            ->add('body','textarea',array('label' => 'contact.label.body'))
        ;
    }

    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Sf\CoreBundle\Entity\Contact'
        ));
    }

    public function getName()
    {
        return 'sf_corebundle_contacttype';
    }
}
