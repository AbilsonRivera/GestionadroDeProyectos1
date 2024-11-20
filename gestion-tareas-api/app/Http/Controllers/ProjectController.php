<?php

namespace App\Http\Controllers;

use App\Models\Project;
use Illuminate\Http\Request;

class ProjectController extends Controller
{
    // Crear un proyecto
    public function store(Request $request)
    {
        $request->validate(['name' => 'required|string']);
    
        $project = new Project();
        $project->name = $request->name;
        $project->user_id = $request->user()->id; // Asegúrate de que el usuario esté autenticado
        $project->save();
    
        return response()->json($project, 201);
    }

    // Obtener todos los proyectos del usuario autenticado
    public function index()
    {
        $projects = Project::where('user_id', auth()->id())->get();
        return response()->json($projects);
    }

    // Obtener un proyecto específico
    public function show($id)
    {
        $project = Project::where('id', $id)->where('user_id', auth()->id())->firstOrFail();
        return response()->json($project);
    }

    // Actualizar un proyecto
    public function update(Request $request, $id)
    {
        // Validación para el campo 'name'
        $request->validate([
            'name' => 'required|string|max:255', // Cambia 'title' a 'name'
        ]);

        $project = Project::where('id', $id)->where('user_id', auth()->id())->firstOrFail();
        $project->name = $request->name;
        $project->save();

        return response()->json($project);
    }

    // Eliminar un proyecto
    public function destroy($id)
    {
        $project = Project::where('id', $id)->where('user_id', auth()->id())->firstOrFail();
        $project->delete();

        return response()->json(['message' => 'Proyecto eliminado'], 200);
    }
}
