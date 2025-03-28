<?php

namespace App\Http\Controllers\api\v1;

use App\Http\Controllers\Controller;
use App\Models\Student;
use Illuminate\Http\Request;

class StudentController extends Controller
{
    /**
     * Return minimum 10 students with name and program
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $students = Student::with('program')
            ->take(10)
            ->get()
            ->map(function ($student) {
                return [
                    'name' => $student->name,
                    'program' => $student->program->name
                ];
            });

        return response()->json([
            'success' => true,
            'count' => $students->count(),
            'data' => $students
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
