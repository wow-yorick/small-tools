<?php
class Scorer
{
	private $ball;
	private $itsThrows = array();
	private $itsCurrentThrow = 0;

	public function addThrow($pins)
	{
		$this->itsThrows[$this->itsCurrentThrow++] = $pins;
	}

	public function scoreForFrame($theFrame)
	{
		$this->ball = 0;
		$score = 0;
		for($currentFrame = 0;$currentFrame < $theFrame;$currentFrame++)
		{
			if($this->strike()) {
				$score += 10 + $this->nextTwoBallsForStrike();
				$this->ball++;
			} else if($this->spare())
			{
				$score += 10 + $this->nextBallsForSpare();
				$this->ball += 2;
			} else {
				$score += $this->twoBallsInFrame();
				$this->ball += 2;
			}
		}
		return $score;
	}

	private function strike()
	{
		return ($this->itsThrows[$this->ball] == 10);
	}

	private function nextTwoBallsForStrike()
	{
		return $this->itsThrows[$this->ball +1] + $this->itsThrows[$this->ball+2];
	}

	private function spare()
	{
		return ($this->itsThrows[$this->ball] + $this->itsThrows[$this->ball + 1]) == 10;
	}

	private function nextBallsForSpare()
	{
		return $this->itsThrows[$this->ball + 2];
	}

	private function twoBallsInFrame()
	{
		return $this->itsThrows[$this->ball] + $this->itsThrows[$this->ball + 1];
	}
}
