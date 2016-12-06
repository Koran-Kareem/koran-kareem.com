<?php

namespace Sf\CoreBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Sf\CoreBundle\Entity\Contact
 *
 * @ORM\Table("contact")
 * @ORM\Entity
 */
class Contact
{
    /**
     * @var integer $id
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var string $name
     * @Assert\NotBlank(message="contact.errors.empty_name")
     * @ORM\Column(name="name", type="string", length=255)
     */
    private $name;

    /**
     * @var string $email
     * @Assert\NotBlank(message="contact.errors.empty_email")
     * @Assert\Email(message="contact.errors.not_valid_email")
     * @ORM\Column(name="email", type="string", length=400)
     */
    private $email;

    /**
     * @var string $subject
     * @Assert\NotBlank(message="contact.errors.empty_subject")
     * @ORM\Column(name="subject", type="string", length=255)
     */
    private $subject;

    /**
     * @var string $body
     * @Assert\NotBlank(message="contact.errors.empty_body")
     * @ORM\Column(name="body", type="text")
     */
    private $body;


    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set name
     *
     * @param string $name
     * @return Contact
     */
    public function setName($name)
    {
        $this->name = $name;
    
        return $this;
    }

    /**
     * Get name
     *
     * @return string 
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set email
     *
     * @param string $email
     * @return Contact
     */
    public function setEmail($email)
    {
        $this->email = $email;
    
        return $this;
    }

    /**
     * Get email
     *
     * @return string 
     */
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * Set subject
     *
     * @param string $subject
     * @return Contact
     */
    public function setSubject($subject)
    {
        $this->subject = $subject;
    
        return $this;
    }

    /**
     * Get subject
     *
     * @return string 
     */
    public function getSubject()
    {
        return $this->subject;
    }

    /**
     * Set body
     *
     * @param string $body
     * @return Contact
     */
    public function setBody($body)
    {
        $this->body = $body;
    
        return $this;
    }

    /**
     * Get body
     *
     * @return string 
     */
    public function getBody()
    {
        return $this->body;
    }
}
