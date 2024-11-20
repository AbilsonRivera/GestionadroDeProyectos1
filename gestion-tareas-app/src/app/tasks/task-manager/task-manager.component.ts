import { Component, OnInit } from '@angular/core';
import { TaskService } from 'src/app/services/task.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-task-manager',
  templateUrl: './task-manager.component.html',
  styleUrls: ['./task-manager.component.scss'],
})
export class TaskManagerComponent implements OnInit {
  projectId!: number;
  tasks: any[] = [];
  newTask: any = { title: '', description: '', is_completed: false };

  constructor(private taskService: TaskService, private route: ActivatedRoute) {}

  ngOnInit() {
    // Obtiene el projectId de la URL
    this.projectId = +this.route.snapshot.paramMap.get('projectId')!;
    // Carga las tareas asociadas con el projectId
    this.loadTasks();
  }

  // Cargar tareas del proyecto actual
  loadTasks() {
    this.taskService.getTasks(this.projectId).subscribe((tasks) => {
      this.tasks = tasks;
    });
  }

  // Crear una nueva tarea
  createTask() {
    if (this.newTask.title) {
      this.taskService.createTask(this.projectId, this.newTask).subscribe((task) => {
        this.tasks.push(task);
        this.newTask = { title: '', description: '', is_completed: false };
      });
    }
  }

  // Actualizar una tarea existente
  updateTask(task: any) {
    this.taskService.updateTask(task.id, task).subscribe((updatedTask) => {
      task = { ...updatedTask };
    });
  }

  // Eliminar una tarea
  deleteTask(taskId: number) {
    this.taskService.deleteTask(taskId).subscribe(() => {
      this.tasks = this.tasks.filter((t) => t.id !== taskId);
    });
  }
}
