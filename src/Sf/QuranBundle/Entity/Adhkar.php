<?php

namespace Sf\QuranBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Adhkar
 *
 * @ORM\Table("adhkar")
 * @ORM\Entity(repositoryClass="Sf\QuranBundle\Repository\AdhkarRepository")
 */
class Adhkar
{
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(name="name", type="string", length=255)
     */
    private $name;

    /**
     * @var string
     *
     * @ORM\Column(name="reciter", type="string", length=255,nullable=true)
     */
    private $reciter;

    /**
     * @var string
     *
     * @ORM\Column(name="ordering", type="string", length=255)
     */
    private $ordering;


    function __toString()
    {
        return $this->name.($this->reciter == "" ? "" : "-".$this->reciter);
    }


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
     * @return Adhkar
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
     * Set ordering
     *
     * @param string $ordering
     * @return Adhkar
     */
    public function setOrdering($ordering)
    {
        $this->ordering = $ordering;
    
        return $this;
    }

    /**
     * Get ordering
     *
     * @return string 
     */
    public function getOrdering()
    {
        return $this->ordering;
    }

    /**
     * @return string
     */
    public function getReciter()
    {
        return $this->reciter;
    }

    /**
     * @param string $reciter
     */
    public function setReciter($reciter)
    {
        $this->reciter = $reciter;
    }
}
