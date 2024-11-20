import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ProjectService } from '../../services/project.service';

@Component({
  selector: 'app-project-manager',
  templateUrl: './project-manager.component.html',
  styleUrls: ['./project-manager.component.scss']
})
export class ProjectManagerComponent implements OnInit {
  projects: any[] = [];
  newProjectName: string = '';
  editProjectId: number | null = null;
  editProjectName: string = '';

  constructor(
    private projectService: ProjectService,
    private router: Router // Inyección del servicio Router
  ) {}

  ngOnInit() {
    this.loadProjects();
  }

  // Cargar proyectos
  loadProjects() {
    this.projectService.getProjects().subscribe((data) => {
      this.projects = data;
    });
  }

  // Redirigir a la lista de tareas del proyecto seleccionado
  viewTasks(projectId: number) {
    this.router.navigate(['/tasks', projectId]);
  }

  // Agregar un proyecto
  addProject() {
    if (this.newProjectName) {
      this.projectService.addProject(this.newProjectName).subscribe((project) => {
        this.projects.push(project);
        this.newProjectName = '';
      });
    }
  }

  // Editar un proyecto
  editProject(project: any) {
    this.editProjectId = project.id;
    this.editProjectName = project.name;
  }

  onLogout() {
    this.projectService.logout().subscribe(() => { // Corrige aquí
      this.router.navigate(['/login']); // Redirige al usuario a la página de inicio de sesión
    });
  }
  

  saveEditProject() {
    if (this.editProjectId && this.editProjectName) {
      this.projectService.updateProject(this.editProjectId, this.editProjectName).subscribe((updatedProject) => {
        const index = this.projects.findIndex((p) => p.id === updatedProject.id);
        if (index !== -1) {
          this.projects[index] = updatedProject;
        }
        this.cancelEdit();
      });
    }
  }

  // Cancelar edición
  cancelEdit() {
    this.editProjectId = null;
    this.editProjectName = '';
  }

  // Eliminar un proyecto
  deleteProject(id: number) {
    this.projectService.deleteProject(id).subscribe(() => {
      this.projects = this.projects.filter((project) => project.id !== id);
    });
  }
}
