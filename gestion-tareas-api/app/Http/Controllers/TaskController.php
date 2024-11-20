<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    // Crear una tarea para un proyecto
    public function store(Request $request, $projectId)
    {
        $request->validate(['title' => 'required|string']);

        $task = new Task();
        $task->title = $request->title;
        $task->description = $request->description;
        $task->project_id = $projectId;
        $task->is_completed = $request->is_completed ?? false;
        $task->save();

        return response()->json($task, 201);
    }

    // Obtener todas las tareas de un proyecto
    public function index($projectId) // Cambia esto para que reciba el ID del proyecto como parámetro
    {
        return Task::where('project_id', $projectId)->get(); // Ya no necesitas usar $request aquí
    }

    // Obtener una tarea específica
    public function show($id)
    {
        $task = Task::findOrFail($id);
        return response()->json($task);
    }

    // Actualizar una tarea
    public function update(Request $request, $id)
    {
        $task = Task::findOrFail($id);
        $task->title = $request->title ?? $task->title;
        $task->description = $request->description ?? $task->description;
        $task->is_completed = $request->is_completed ?? $task->is_completed;
        $task->save();

        return response()->json($task);
    }

    // Eliminar una tarea
    public function destroy($id)
    {
        $task = Task::findOrFail($id);
        $task->delete();

        return response()->json(['message' => 'Tarea eliminada'], 200);
    }
}
