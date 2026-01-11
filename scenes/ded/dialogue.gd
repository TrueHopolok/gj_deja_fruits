class_name Dialogue
extends Node

@export_group("Unsolved")
@export var text_unsolved: Array[String] = []
@export var is_boy_unsolved: Dictionary = {}

@export_group("Solved")
@export var text_solved: Array[String] = []
@export var is_boy_solved: Dictionary = {}
@export var scene_to_change: PackedScene
