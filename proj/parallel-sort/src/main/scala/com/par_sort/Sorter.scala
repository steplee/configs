package com.par_sort

import akka.actor.{Props, Actor}
import akka.actor.Actor.Receive
import akka.pattern.ask
import akka.util.Timeout
;
import com.par_sort.Sorter.{SortResp, SortReq}

import scala.collection.mutable.Seq
import scala.concurrent.{Await, ExecutionContext, Future}
;

/**
  * Created by lslee on 3/2/16.
  *
  * Based on the wikipedia implementation in Python
  *
  */

object Sorter {
  def props() = Props(new Sorter());

  case class SortReq(seq:Seq[Int], start:Int, end:Int);
  case class SortResp(sorted:Seq[Int]);
}
class Sorter extends Actor {
  type ST[TT] = scala.collection.mutable.Seq[TT];

  //case class SortReq(seq:scala.collection.mutable.Seq[T:Ordered], start:Int, end:Int);


  override def receive: Receive = {
    case SortReq(seq, s,e ) => {
      if (s >= e || seq.length == 1) {
        sender() ! SortResp(seq)
        println("Sending \t" + s + "\t" + e);
      }
      if (e-s > 1005) {
        println (s"Splitting at index ${(e-s+1)/2}")
        val mid = (e-s+1)/2;
        val (left,right) = seq.splitAt(mid);

        val l_child = context.actorOf(Sorter.props(), "left");
        val r_child = context.actorOf(Sorter.props(), "right");
        import context.dispatcher

        implicit val timeout = Timeout(500000);
        val l_fut = ask(l_child , SortReq( left , 0, mid ));
        //val r_fut = ask(r_child , SortReq( right, 0, mid ));

        //val lr = Await.result(l_fut, timeout.duration).asInstanceOf[Seq[Int]];
        //val rr = Await.result(r_fut, timeout.duration).asInstanceOf[Seq[Int]];

        //val sortedSeq = Seq.concat(lr,rr);
        val sortedSeq = seq;
        sender() ! SortResp(sortedSeq)
        println("Sending \t" + s + "\t" + e);

      } else {
        // do now and send
        println("Recv:3 \t" + s + "\t" + e);
        val sortedSeq = bitonic_sort(true, seq);
        println("Sorted:3 \t" + s + "\t" + e);
        sender() ! SortResp(sortedSeq)
        println("Sending \t" + s + "\t" + e);
      }
    }
  }


  def bitonic_sort(up:Boolean, seq:ST[Int]) : ST[Int] = {
    if (seq.length == 1) seq
    else {
      val mid = (seq.length+1) / 2;
      //println ("Mid: " + mid + " -- Seq: " + seq.toString);
      val left = bitonic_sort(true, seq.slice(0, mid))
      val right = bitonic_sort(false, seq.slice(mid, seq.length))
      bitonic_merge(up, Seq.concat(left, right))
    }
  }

  private def bitonic_merge(up:Boolean, seq: ST[Int]) : ST[Int] = {
    if (seq.length == 1) seq
    else {
      val ordered = bitonic_compare(up, seq)

      val mid = (ordered.length + 1) / 2;
      val left = bitonic_merge(up, ordered.slice(0, mid))
      val right = bitonic_merge(up, ordered.slice(mid, seq.length))

      collection.mutable.Seq.concat(left, right);
    }
  }

    private def bitonic_compare(up:Boolean, seq: ST[Int]) = {
      if (seq.length == 1) seq
      else {
        val mid = (seq.length+1) / 2;

        for (x <- 0 to mid-1) {
          if ( (seq(x).compare( seq(x+mid) ) >0) == up) {
            val tmp = seq(x);
            seq(x) = seq(x+mid);
            seq(x+mid) = tmp;
          }
        }
        seq;
      }
    }

}
