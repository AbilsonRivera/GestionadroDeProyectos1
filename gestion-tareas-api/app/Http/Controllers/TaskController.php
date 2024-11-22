<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class TaskController extends Controller
{
    // Crear una tarea para un proyecto
    public function store(Request $request, $projectId)
{
    $request->validate(['title' => 'required|string']);

    // Llamar al procedimiento almacenado `insert_task`
    DB::select('CALL insert_task(?, ?, ?, ?)', [
        $request->title,          // Título de la tarea
        $request->description,    // Descripción de la tarea (puede ser NULL)
        $request->is_completed ?? false, // Estado de completado (default 0 si no se proporciona)
        $projectId,               // ID del proyecto asociado
    ]);

    // Retornamos la tarea creada (por ahora no podemos obtener el resultado porque no es un SELECT, 
    // se podría modificar para que devuelva la tarea recién creada si lo deseas).
    return response()->json([
        'message' => 'Tarea creada exitosamente.'
    ], 201);
}


    // Obtener todas las tareas de un proyecto
    public function index($projectId) 
    {
        return Task::where('project_id', $projectId)->get();
    }


    // Actualizar una tarea
    public function update(Request $request, $id)
{
    // Validación para asegurarse de que el parámetro 'is_completed' sea booleano
    $request->validate([
        'is_completed' => 'required|boolean'
    ]);

    // Llamar al procedimiento almacenado `update_task` para actualizar solo el estado de completado
    DB::select('CALL update_task(?, ?)', [
        $id,                             // ID de la tarea a actualizar
        $request->is_completed           // Nuevo estado de completado (0 o 1)
    ]);

    // Recuperar la tarea actualizada
    $task = Task::find($id);

    // Retornar la tarea actualizada
    return response()->json($task);
}


    // Eliminar una tarea
    public function destroy($id)
{
    try {
        // Llamar al procedimiento almacenado `delete_task` para eliminar la tarea
        DB::select('CALL delete_task(?)', [
            $id // ID de la tarea a eliminar
        ]);

        // Si no ocurre ninguna excepción, retornamos un mensaje de éxito
        return response()->json(['message' => 'Tarea eliminada'], 200);
    } catch (\Exception $e) {
        // Si ocurre un error al ejecutar el procedimiento almacenado, lo capturamos
        return response()->json(['error' => 'No se pudo eliminar la tarea'], 400);
    }
}

}
