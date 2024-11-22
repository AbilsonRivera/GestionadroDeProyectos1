<?php

namespace App\Http\Controllers;

use App\Models\Project;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class ProjectController extends Controller
{
    // Crear un proyecto
    public function store(Request $request)
{
    $request->validate(['name' => 'required|string']);

    // Llamar al procedimiento almacenado insert_project
    $result = DB::select('CALL insert_project(?, ?)', [
        $request->name,  // Nombre del proyecto
        $request->user()->id // ID del usuario autenticado
    ]);

    // Si el procedimiento devuelve resultados, retornamos el proyecto creado
    return response()->json($result[0], 201);
}


    // Obtener todos los proyectos del usuario autenticado
    public function index()
    {
        $projects = Project::where('user_id', auth()->id())->get();
        return response()->json($projects);
    }


    // Actualizar un proyecto
    public function update(Request $request, $id)
{
    $request->validate(['name' => 'required|string|max:255']);

    // Llamar al procedimiento almacenado update_project
    $result = DB::select('CALL update_project(?, ?, ?)', [
        $id, // ID del proyecto
        auth()->id(), // ID del usuario autenticado
        $request->name, // Nuevo nombre para el proyecto
    ]);

    // Si el procedimiento devuelve resultados, retornamos el proyecto actualizado
    if (isset($result[0]->id)) {
        return response()->json($result[0]);
    } else {
        return response()->json(['error' => 'No se pudo actualizar el proyecto o no pertenece al usuario'], 400);
    }
}


    // Eliminar un proyecto
    public function destroy($id)
{
    try {
        // Llamar al procedimiento almacenado 'delete_project'
        DB::select('CALL delete_project(?, ?)', [
            $id, // ID del proyecto
            auth()->id(), // ID del usuario autenticado
        ]);

        // Si no hay excepciones, retornamos el mensaje de éxito
        return response()->json(['message' => 'Proyecto eliminado'], 200);
    } catch (\Exception $e) {
        // Si el procedimiento almacenado lanza un error, se captura aquí
        return response()->json(['error' => 'No se pudo eliminar el proyecto o no pertenece al usuario'], 400);
    }
}

}