import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';

interface Task {
  id?: number;
  title: string;
  description?: string;
  is_completed?: boolean;
  project_id: number;
}

@Injectable({
  providedIn: 'root'
})
export class TaskService {
  private apiUrl = 'http://localhost:8000/api';

  constructor(private http: HttpClient) {}

  // Obtener todas las tareas de un proyecto
  getTasks(projectId: number): Observable<Task[]> {
    return this.http.get<Task[]>(`${this.apiUrl}/projects/${projectId}/tasks`);
  }

  // Obtener una tarea específica
  getTask(id: number): Observable<Task> {
    return this.http.get<Task>(`${this.apiUrl}/tasks/${id}`);
  }

  // Crear una nueva tarea
  createTask(projectId: number, task: Task): Observable<Task> {
    return this.http.post<Task>(`${this.apiUrl}/projects/${projectId}/tasks`, task);
  }

  // Actualizar una tarea
  updateTask(id: number, task: Task): Observable<Task> {
    return this.http.put<Task>(`${this.apiUrl}/tasks/${id}`, task);
  }

  // Eliminar una tarea
  deleteTask(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/tasks/${id}`);
  }
}
