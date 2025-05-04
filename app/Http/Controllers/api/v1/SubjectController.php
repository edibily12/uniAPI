<?php

namespace App\Http\Controllers\api\v1;

use App\Http\Controllers\Controller;
use App\Models\Program;
use App\Models\Year;
use Illuminate\Http\Request;

class SubjectController extends Controller
{
    /**
     * Return all subjects for Software Engineering program by year
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        try {
            $programId = Program::where('name', 'Software Engineering')->firstOrFail()->id;

            $subjectsByYear = Year::with(['subjects' => function ($query) use ($programId) {
                $query->where('program_id', $programId)
                    ->select('id', 'name', 'program_id', 'year_id');
            }])
                ->get()
                ->mapWithKeys(function ($year) {
                    return [
                        $year->name => $year->subjects->map(function ($subject) {
                            return [
                                'id' => $subject->id,
                                'name' => $subject->name
                            ];
                        })
                    ];
                });

            return response()->json([
                'success' => true,
                'program' => 'Software Engineering',
                'data' => $subjectsByYear
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Database connection error',
                'error' => $e->getMessage()
            ], 500);
        }
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
