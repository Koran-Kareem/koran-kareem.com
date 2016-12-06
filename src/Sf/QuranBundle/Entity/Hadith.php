<?php

namespace Sf\QuranBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Hadith
 *
 * @ORM\Table("hadith")
 * @ORM\Entity(repositoryClass="Sf\QuranBundle\Repository\HadithRepository")
 */
class Hadith
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
     * @var \Sf\QuranBundle\Entity\HadithCategory
     * @ORM\ManyToOne(targetEntity="\Sf\QuranBundle\Entity\HadithCategory")
     * @ORM\JoinColumn(name="category_id", referencedColumnName="id",nullable=true)
     */
    private $category;

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
     * @return Hadith
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
     * @return Hadith
     */
    public function setordering($ordering)
    {
        $this->ordering = $ordering;

        return $this;
    }

    /**
     * Get ordering
     *
     * @return string
     */
    public function getordering()
    {
        return $this->ordering;
    }

    /**
     * @return \Sf\QuranBundle\Entity\HadithCategory
     */
    public function getCategory()
    {
        return $this->category;
    }

    /**
     * @param \Sf\QuranBundle\Entity\HadithCategory $category
     */
    public function setCategory($category)
    {
        $this->category = $category;
        return $this;
    }

    /**
     * @return string
     */
    function __toString()
    {
        return $this->name;
    }
}
