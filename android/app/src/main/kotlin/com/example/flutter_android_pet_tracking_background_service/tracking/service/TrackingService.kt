package com.example.personal_safety.tracking.service

interface TrackingService {
    fun start()
    fun stop()
    fun isTracking(): Boolean
    fun attachListener(listener: PetTrackingListener?)
}