-- Migration: Add payment columns to appointments table
-- Run this in your Supabase SQL Editor

-- Add payment columns to appointments table
ALTER TABLE public.appointments ADD COLUMN IF NOT EXISTS payment_status VARCHAR(50) DEFAULT 'unpaid';
ALTER TABLE public.appointments ADD COLUMN IF NOT EXISTS consultation_fee NUMERIC(10, 2) DEFAULT 500.00;
ALTER TABLE public.appointments ADD COLUMN IF NOT EXISTS razorpay_order_id VARCHAR(255);
ALTER TABLE public.appointments ADD COLUMN IF NOT EXISTS razorpay_payment_id VARCHAR(255);
ALTER TABLE public.appointments ADD COLUMN IF NOT EXISTS razorpay_signature VARCHAR(255);
