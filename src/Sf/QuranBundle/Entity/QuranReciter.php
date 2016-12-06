<?php

namespace Sf\QuranBundle\Entity;

use Gedmo\Mapping\Annotation as Gedmo;
use Doctrine\ORM\Mapping as ORM;

/**
 * Sf\QuranBundle\Entity\QuranReciter
 *
 * @ORM\Table("quran_reciter")
 * @ORM\Entity(repositoryClass="Sf\QuranBundle\Repository\QuranReciterRepository")
 */
class QuranReciter
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
     * @var string $arabicName
     *
     * @ORM\Column(name="arabic_name", type="string", length=255)
     */
    private $arabicName;

    /**
     * @var string $history
     *
     * @ORM\Column(name="history", type="text", nullable=true)
     */
    private $history;

    /**
     * @Gedmo\Slug(fields={"name"})
     * @ORM\Column(length=255, unique=true)
     */
    private $slug;

    /**
     * @var boolean $active
     *
     * @ORM\Column(name="active", type="boolean")
     */
    private $active;

    /**
     * @var \Sf\QuranBundle\Entity\Country
     * @ORM\ManyToOne(targetEntity="\Sf\QuranBundle\Entity\Country")
     * @ORM\JoinColumn(name="country_id", referencedColumnName="id",nullable=true)
     */
    private $country;

    public function __toString()
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
     * @return QuranReciter
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
     * Set active
     *
     * @param boolean $active
     * @return QuranReciter
     */
    public function setActive($active)
    {
        $this->active = $active;

        return $this;
    }

    /**
     * Get active
     *
     * @return boolean
     */
    public function getActive()
    {
        return $this->active;
    }

    /**
     * Set slug
     *
     * @param string $slug
     * @return QuranReciter
     */
    public function setSlug($slug)
    {
        $this->slug = $slug;

        return $this;
    }

    /**
     * Get slug
     *
     * @return string
     */
    public function getSlug()
    {
        return $this->slug;
    }

    /**
     * @return string
     */
    public function getArabicName()
    {
        return trim($this->arabicName);
    }

    /**
     * @param string $arabicName
     */
    public function setArabicName($arabicName)
    {
        $this->arabicName = $arabicName;
    }

    /**
     * @return string
     */
    public function getHistory()
    {
        return $this->history;
    }

    /**
     * @param string $history
     */
    public function setHistory($history)
    {
        $this->history = $history;
    }

    /**
     * @return \Sf\QuranBundle\Entity\Country
     */
    public function getCountry()
    {
        return $this->country;
    }

    /**
     * @param \Sf\QuranBundle\Entity\Country $country
     */
    public function setCountry($country)
    {
        $this->country = $country;
    }
}
