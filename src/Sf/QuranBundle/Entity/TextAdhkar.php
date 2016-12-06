<?php

namespace Sf\QuranBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * TextAdhkar
 *
 * @ORM\Table()
 * @ORM\Entity
 */
class TextAdhkar
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
     * @ORM\Column(name="text", type="text")
     */
    private $text;

    /**
     * @var string
     *
     * @ORM\Column(name="source", type="string", length=255, nullable=true)
     */
    private $source;

    /**
     * @var \Sf\QuranBundle\Entity\TextAdhkarCategory
     * @ORM\ManyToOne(targetEntity="\Sf\QuranBundle\Entity\TextAdhkarCategory")
     * @ORM\JoinColumn(name="category_id", referencedColumnName="id",nullable=true)
     */
    private $category;

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
     * Set source
     *
     * @param string $source
     * @return TextAdhkar
     */
    public function setSource($source)
    {
        $this->source = $source;
    
        return $this;
    }

    /**
     * Get source
     *
     * @return string 
     */
    public function getSource()
    {
        return $this->source;
    }

    /**
     * @return \Sf\QuranBundle\Entity\TextAdhkarCategory
     */
    public function getCategory()
    {
        return $this->category;
    }

    /**
     * @param \Sf\QuranBundle\Entity\TextAdhkarCategory $category
     */
    public function setCategory($category)
    {
        $this->category = $category;
    }

    /**
     * @return string
     */
    public function getText()
    {
        return $this->text;
    }

    /**
     * @param string $text
     */
    public function setText($text)
    {
        $this->text = $text;
    }

}
