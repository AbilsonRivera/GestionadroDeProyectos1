import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators'; 


@Injectable({
  providedIn: 'root'
})
export class ProjectService {
  private apiUrl = 'http://localhost:8000/api/projects'; 

  constructor(private http: HttpClient) {}

  // Obtener todos los proyectos
  getProjects(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }

  // Crear un nuevo proyecto
  addProject(name: string): Observable<any> {
    return this.http.post<any>(this.apiUrl, { name });
  }

  // Editar un proyecto existente
  updateProject(id: number, name: string): Observable<any> {
    return this.http.put<any>(`${this.apiUrl}/${id}`, { name });
  }

  // Eliminar un proyecto
  deleteProject(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/${id}`);
  }

  logout() {
    return this.http.post('http://localhost:8000/api/logout', {}).pipe(
      tap(() => {
        // Eliminar el token localmente
        localStorage.removeItem('auth_token');
      })
    );
  }
  
}
