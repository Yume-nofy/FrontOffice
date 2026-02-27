INSERT INTO public.reservation (idclient, idhotel, nb_passager, date_arrivee) VALUES
-- Groupe 1 : Réservations rapprochées (moins de 30 min d'écart) - DEVRAIT ÊTRE GROUPÉ
('CL001', 1, 3, '2024-01-15 08:00:00'), -- Colbert, 3 pers
('CL002', 2, 2, '2024-01-15 08:20:00'), -- Novotel, 2 pers (total groupe = 5 pers)

-- Groupe 2 : Réservation seule (écart > 30 min avec la précédente)
('CL003', 3, 4, '2024-01-15 09:00:00'), -- Ibis, 4 pers

-- Groupe 3 : Réservations très rapprochées (moins de 30 min)
('CL004', 1, 2, '2024-01-15 10:00:00'), -- Colbert, 2 pers
('CL005', 4, 3, '2024-01-15 10:15:00'), -- Lokanga, 3 pers (total groupe = 5 pers)

-- Groupe 4 : Réservation seule
('CL006', 2, 6, '2024-01-15 11:00:00'), -- Novotel, 6 pers (trop grand pour un véhicule de 5 places)

-- Groupe 5 : Réservations rapprochées mais capacité totale > véhicule dispo
('CL007', 3, 4, '2024-01-15 14:00:00'), -- Ibis, 4 pers
('CL008', 4, 4, '2024-01-15 14:20:00'), -- Lokanga, 4 pers (total = 8 pers, dépasse la capacité du prochain véhicule)

-- Groupe 6 : Réservations pour tester le tri des véhicules
('CL009', 1, 2, '2024-01-15 15:00:00'), -- Colbert, 2 pers
('CL010', 1, 3, '2024-01-15 15:10:00'), -- Colbert, 3 pers (total = 5 pers)
('CL011', 2, 1, '2024-01-15 15:20:00'); -- Novotel, 1 pers (total final = 6 pers, dépasse)
