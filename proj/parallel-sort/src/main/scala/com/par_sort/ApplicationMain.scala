package com.par_sort

import akka.actor.{Props, ActorSystem}

import scala.collection.mutable

object ApplicationMain extends App {
  /*
  val system = ActorSystem("MyActorSystem")
  val pingActor = system.actorOf(PingActor.props, "pingActor")
  pingActor ! PingActor.Initialize
  // This example app will ping pong 3 times and thereafter terminate the ActorSystem - 
  // see counter logic in PingActor
  system.awaitTermination()
  */
  val system = ActorSystem("MyActorSystem")
  val root = system.actorOf(Props[RootActor], "root");


}