<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    use HasFactory;

    protected $fillable = ['program_id', 'name', 'enrollment_date'];

    protected $casts = [
        'enrollment_date' => 'date',
    ];

    public function program()
    {
        return $this->belongsTo(Program::class);
    }
}
