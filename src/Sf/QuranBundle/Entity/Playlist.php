<?php

namespace Sf\QuranBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Playlist
 *
 * @ORM\Table("playlist")
 * @ORM\Entity
 */
class Playlist
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
     * @var \Doctrine\Common\Collections\ArrayCollection()
     * @ORM\OneToMany(targetEntity="\Sf\QuranBundle\Entity\PlaylistItem", mappedBy="playlist",cascade={"remove"})
     */
    private $items;

    /**
     * @var \Sf\UserBundle\Entity\User
     * @ORM\ManyToOne(targetEntity="Sf\UserBundle\Entity\User",cascade={"persist"})
     * @ORM\JoinColumn(name="user", referencedColumnName="id", onDelete="SET NULL")
     */
    private $user;

    public function __construct() {
        $this->items = new \Doctrine\Common\Collections\ArrayCollection();
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
     * @return Playlist
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
     * @return \Sf\UserBundle\Entity\User
     */
    public function getUser()
    {
        return $this->user;
    }

    /**
     * @param \Sf\UserBundle\Entity\User $user
     */
    public function setUser($user)
    {
        $this->user = $user;

        return $this;
    }

    /**
     * @return \Doctrine\Common\Collections\ArrayCollection()
     */
    public function getItems()
    {
        return $this->items;
    }

    /**
     * @param \Doctrine\Common\Collections\ArrayCollection() $items
     */
    public function setItems($items)
    {
        $this->items = $items;
        return $this;
    }

    /**
     * @param \Sf\QuranBundle\Entity\PlaylistItem $items
     */
    public function addItems($items)
    {
        $this->items[] = $items;
    }


}
