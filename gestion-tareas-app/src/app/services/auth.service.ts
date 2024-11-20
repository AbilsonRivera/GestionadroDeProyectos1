import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators'; 

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = 'http://127.0.0.1:8000/api'; 

  constructor(private http: HttpClient) {}

  login(credentials: { email: string; password: string }): Observable<any> {
    return this.http.post<{ token: string }>(`${this.apiUrl}/login`, credentials).pipe(
      tap((response: { token: string }) => { // Define el tipo del response
        localStorage.setItem('token', response.token); // Guarda el token en el localStorage
      })
    );
  }

  register(userData: { name: string; email: string; password: string }): Observable<any> {
    return this.http.post(`${this.apiUrl}/register`, userData);
  }
}
