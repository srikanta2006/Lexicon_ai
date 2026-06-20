-- Migration: Create deal_bundles table
-- Run this in your Supabase SQL Editor

-- 1. Create deal_bundles table
CREATE TABLE IF NOT EXISTS public.deal_bundles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    document_ids JSONB NOT NULL DEFAULT '[]'::jsonb, -- Array of document UUID strings
    inconsistency_report JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2. Enable RLS
ALTER TABLE public.deal_bundles ENABLE ROW LEVEL SECURITY;

-- 3. RLS policies
DROP POLICY IF EXISTS "Users can manage their own deal bundles" ON public.deal_bundles;
CREATE POLICY "Users can manage their own deal bundles" ON public.deal_bundles
    FOR ALL USING (
        auth.uid() = user_id
    ) WITH CHECK (
        auth.uid() = user_id
    );

-- 4. Create index
CREATE INDEX IF NOT EXISTS idx_deal_bundles_user_id ON public.deal_bundles(user_id);
