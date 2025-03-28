<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Subject extends Model
{
    /** @use HasFactory<\Database\Factories\SubjectFactory> */
    use HasFactory;

    protected $fillable = [
            'program_id',
            'year_id',
            'name',
            'description',
    ];

    public function program()
    {
        return $this->belongsTo(Program::class);
    }

    public function year()
    {
        return $this->belongsTo(Year::class);
    }
}
