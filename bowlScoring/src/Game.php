<?php
require_once 'Scorer.php';
class Game
{
	private $firstThrowInFrame = true;
	private $itsCurrentFrame = 0;

	private $itsScorer;

	public function __construct()
	{
		$this->itsScorer = new Scorer();
	}

	public function score()
	{
		return $this->scoreForFrame($this->itsCurrentFrame);
	}

	public function add($pins)
	{
		$this->itsScorer->addThrow($pins);
		$this->adjustCurrentFrame($pins);
		
	}

	private function adjustCurrentFrame($pins)
	{
		if($this->lastBallInFrame($pins)) {
			$this->advanceFrame();
		} else {
			$this->firstThrowInFrame = false;
		}
		
	}

	private function lastBallInFrame($pins)
	{
		 return $this->strike($pins) || (!$this->firstThrowInFrame);
	}

	private function strike($pins)
	{
		return ($this->firstThrowInFrame && $pins == 10);
	}

	private function advanceFrame()
	{
		$this->firstThrowInFrame = true;
		$this->itsCurrentFrame = min(10, $this->itsCurrentFrame+1);
	}

	public function scoreForFrame($theFrame)
	{
		return $this->itsScorer->scoreForFrame($theFrame);
	}

	public function getCurrentFrame()
	{
		return $this->itsCurrentFrame;
	}

}
