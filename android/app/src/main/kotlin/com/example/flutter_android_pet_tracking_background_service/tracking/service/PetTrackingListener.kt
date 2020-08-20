package com.example.personal_safety.tracking.service

import com.example.personal_safety.tracking.model.PathLocation

interface PetTrackingListener {
    fun onNewLocation(location: PathLocation)
}