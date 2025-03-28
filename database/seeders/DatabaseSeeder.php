<?php

namespace Database\Seeders;

use App\Models\Program;
use App\Models\Student;
use App\Models\Subject;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\Year;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run()
    {
        // Create programs
        $seProgram = Program::create([
            'name' => 'Software Engineering',
            'description' => 'Software Engineering Program'
        ]);

        // Create years
        $years = Year::factory()->createMany([
            ['name' => 'Year 1'],
            ['name' => 'Year 2'],
            ['name' => 'Year 3'],
            ['name' => 'Year 4']
        ]);

        // Create subjects for each year
        $subjects = [
            'Year 1' => [
                'Principles of Programming Languages', 'Mathematical Foundations of Information Security', 'Introduction to Information Technology',
                'Communication Skills', 'Introduction to Computer Networking', 'Introduction to Database systems', '	Introduction to High Level Programming',
                'Introduction to Software Engineering','Introduction to IT Security'
            ],
            'Year 2' => [
                'Computer Networking Protocols', '	Introduction To Linux/Unix Systems','Data Structures and Algorithms Analysis',
                'Object Oriented Programming in Java','Internet Programming And Application I','Database Management Systems','Software Testing and Quality Assurance'
            ],
            'Year 3' => [
                'Internet Programming and Applications II', 'Python Programming','Mobile Applications Development','Embedded Systems I',
                'Distributed Database Systems', 'Data Mining and Warehousing','Web Framework Development Using Javascript',
                'Advanced Java Programming','Secure Systems Development'
            ],
            'Year 4' => [
                    'Distributed Computing','C# Programming','Software Reverse Engineering','Cloud Computing', 'Software Development and Management',
                    'Foundation Data Science', 'Big Data Analysis'
                ]
        ];

        foreach ($subjects as $yearName => $subjectNames) {
            $year = Year::where('name', $yearName)->first();
            foreach ($subjectNames as $subjectName) {
                Subject::create([
                    'name' => $subjectName,
                    'program_id' => $seProgram->id,
                    'year_id' => $year->id
                ]);
            }
        }

        // Create 10+ students
        Student::factory(20)->create(['program_id' => $seProgram->id ]);
    }
}
