-- Circuits Metrics Layer

create table `project-1-music-489315.Formula_1.circuit_metrics` as (


with results_master as (

  select * from `project-1-music-489315.Formula_1.results_master`
),

-- Metrics to Compute

circuit_totals as (
select circuit_name,
  count(raceId) as total_races, 
  sum(points) as total_points, 
  sum(case when position = 1 then 1 else 0 end) as total_wins, 
  sum(case when position <= 3 then 1 else 0 end) as total_podiums, 
  sum(case when race_status = 'is_dnf' then 1 else 0 end) as total_dnfs
  from results_master
  group by circuit_name


),

circuit_stats as (

select *,
  round(total_points * 1.0 / total_races, 2) as points_per_race, 
  round(total_wins / total_races, 2) as win_rate, 
  round(total_podiums / total_races, 2) as podium_rate, 
  round(total_dnfs / total_races, 2) as dnf_rate 
  from circuit_totals
  where total_races >= 50
  order by total_races desc
)

select * from circuit_stats limit 20

)
