<?php
use PHPUnit\Framework\TestCase;
class GameTest extends TestCase
{
	private $game;

	public function setUp()
	{
		parent::setUp();
		$this->game = new Game();

	}


	public function testTwoThrowsNoMark()
	{
		$this->game->add(5);
		$this->game->add(4);
		$this->assertEquals(9,$this->game->scoreForFrame(1));
		$this->assertEquals(9,$this->game->score());
		$this->assertEquals(1,$this->game->getCurrentFrame());
	}

	public function testFourThrowsNoMark()
	{
		$this->game->add(5);
		$this->game->add(4);
		$this->game->add(7);
		$this->game->add(2);
		$this->assertEquals(9,$this->game->scoreForFrame(1));
		$this->assertEquals(18,$this->game->scoreForFrame(2));
		$this->assertEquals(2,$this->game->getCurrentFrame());
		$this->assertEquals(18,$this->game->score());
	}

	public function testSimpleSpare()
	{
		$this->game->add(3);
		$this->game->add(7);
		$this->game->add(3);
		$this->assertEquals(13,$this->game->scoreForFrame(1));
		$this->assertEquals(1,$this->game->getCurrentFrame());
	}

	public function testSimpleFrameAfterSpare()
	{
		$this->game->add(3);
		$this->game->add(7);
		$this->game->add(3);
		$this->game->add(2);
		$this->assertEquals(13, $this->game->scoreForFrame(1));
		$this->assertEquals(18, $this->game->scoreForFrame(2));
		$this->assertEquals(18, $this->game->score());
	}

	public function testAllIn()
	{
		$this->game->add(10);
		$this->game->add(3);
		$this->game->add(6);
		$this->assertEquals(19, $this->game->scoreForFrame(1));
		$this->assertEquals(28, $this->game->score());
	}

	public function testPerfectGame()
	{
		for($i=0; $i< 12; $i++)
		{
			$this->game->add(10);
		}
		$this->assertEquals(300, $this->game->score());

	}

	public function testEndOfArray()
	{
		for($i = 0; $i < 9; $i++)
		{
			$this->game->add(0);
			$this->game->add(0);
		}
		$this->game->add(2);
		$this->game->add(8);
		$this->game->add(10);
		$this->assertEquals(20, $this->game->score());
	}

	public function testSimpleGame()
	{
		$this->game->add(1);
		$this->game->add(4);
		$this->game->add(4);
		$this->game->add(5);
		$this->game->add(6);
		$this->game->add(5);
		$this->game->add(6);
		$this->game->add(6);
		$this->game->add(10);
		$this->game->add(0);
		$this->game->add(1);
		$this->game->add(7);
		$this->game->add(3);
		$this->game->add(6);
		$this->game->add(4);
		$this->game->add(10);
		$this->game->add(2);
		$this->game->add(8);
		$this->game->add(6);
		$this->assertEquals(121, $this->game->score());
	}

	public function testHeartBreak()
	{
		for($i = 0; $i < 11; $i++)
		{
			$this->game->add(10);
		}
		$this->game->add(9);
		$this->assertEquals(299,$this->game->score());
	}

	public function testTenthFrameSpare()
	{
		for($i =0; $i <9; $i++)
		{
			$this->game->add(10);
		}
		$this->game->add(9);
		$this->game->add(1);
		$this->game->add(1);
		$this->assertEquals(270,$this->game->score());
	}

	
}
