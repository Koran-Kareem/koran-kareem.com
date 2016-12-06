<?php

namespace Sf\QuranBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Sf\QuranBundle\Entity\Chapter
 *
 * @ORM\Table("chapter")
 * @ORM\Entity
 */
class Chapter
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
     *
     * @ORM\Column(name="name", type="string", length=255)
     */
    private $name;

    /**
     * @var string $ordering
     *
     * @ORM\Column(name="ordering", type="string", length=255)
     */
    private $ordering;

    function __toString()
    {
        return $this->name;
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
     * @return Chapter
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
     * @return string
     */
    public function getOrdering()
    {
        return $this->ordering;
    }

    /**
     * @param string $ordering
     */
    public function setOrdering($ordering)
    {
        $this->ordering = $ordering;
    }
}
