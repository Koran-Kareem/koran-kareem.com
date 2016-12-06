<?php

namespace Sf\QuranBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Tilawa
 *
 * @ORM\Table("tilawa")
 * @ORM\Entity(repositoryClass="Sf\QuranBundle\Repository\TilawaRepository")
 */
class Tilawa
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
     * @ORM\Column(name="ordering", type="string", length=255)
     */
    private $ordering;


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
     * @return Tilawa
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
     * @return Tilawa
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
}
