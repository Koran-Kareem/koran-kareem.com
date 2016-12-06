<?php

namespace Sf\QuranBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * PlaylistItem
 *
 * @ORM\Table("playlist_item")
 * @ORM\Entity
 */
class PlaylistItem
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
     * @var \Sf\QuranBundle\Entity\Playlist
     * @ORM\ManyToOne(targetEntity="Sf\QuranBundle\Entity\Playlist", inversedBy="items",cascade={"persist"})
     * @ORM\JoinColumn(name="playlist_id", referencedColumnName="id",onDelete="SET NULL")
     */
    private $playlist;

    /**
     * @var \Sf\QuranBundle\Entity\QuranReciter
     * @ORM\ManyToOne(targetEntity="Sf\QuranBundle\Entity\QuranReciter")
     * @ORM\JoinColumn(name="reciter_id", referencedColumnName="id",nullable=true)
     */
    private $reciter;

    /**
     * @var \Sf\QuranBundle\Entity\Chapter
     * @ORM\ManyToOne(targetEntity="Sf\QuranBundle\Entity\Chapter")
     * @ORM\JoinColumn(name="chapter_id", referencedColumnName="id",nullable=true)
     */
    private $chapter;

    /**
     * @var \Sf\QuranBundle\Entity\Adhkar
     * @ORM\ManyToOne(targetEntity="Sf\QuranBundle\Entity\Adhkar")
     * @ORM\JoinColumn(name="adhkar_id", referencedColumnName="id",nullable=true)
     */
    private $adhkar;

    /**
     * @var \Sf\QuranBundle\Entity\Tilawa
     * @ORM\ManyToOne(targetEntity="Sf\QuranBundle\Entity\Tilawa")
     * @ORM\JoinColumn(name="tilawa_id", referencedColumnName="id",nullable=true)
     */
    private $tilawa;

    /**
     * @var string $type
     * @ORM\Column(name="type", type="string", length=255)
     */
    private $type;


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
     * @return QuranReciter
     */
    public function getReciter()
    {
        return $this->reciter;
    }

    /**
     * @param $reciter
     * @return PlaylistItem
     */
    public function setReciter($reciter)
    {
        $this->reciter = $reciter;
        return $this;
    }

    /**
     * @return Chapter
     */
    public function getChapter()
    {
        return $this->chapter;
    }

    /**
     * @param $chapter
     * @return PlaylistItem
     */
    public function setChapter($chapter)
    {
        $this->chapter = $chapter;
        return $this;
    }

    /**
     * @return \Sf\QuranBundle\Entity\Playlist
     */
    public function getPlaylist()
    {
        return $this->playlist;
    }

    /**
     * @param \Sf\QuranBundle\Entity\Playlist $playlist
     */
    public function setPlaylist($playlist)
    {
        $this->playlist = $playlist;
        return $this;
    }

    /**
     * @return \Sf\QuranBundle\Entity\Adhkar
     */
    public function getAdhkar()
    {
        return $this->adhkar;
    }

    /**
     * @param \Sf\QuranBundle\Entity\Adhkar $adhkar
     */
    public function setAdhkar($adhkar)
    {
        $this->adhkar = $adhkar;
        return $this;
    }

    /**
     * @return string
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * @param string $type
     */
    public function setType($type)
    {
        $this->type = $type;
        return $this;
    }

    /**
     * @return \Sf\QuranBundle\Entity\Tilawa
     */
    public function getTilawa()
    {
        return $this->tilawa;
    }

    /**
     * @param \Sf\QuranBundle\Entity\Tilawa $tilawa
     */
    public function setTilawa($tilawa)
    {
        $this->tilawa = $tilawa;
        return $this;
    }


}
