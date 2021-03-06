function opt = setup_global_nelder_mead(this, gui, varargin)
this.solver = 'global_nelder_mead';
opt = struct( ...
    'use_param_set_as_init',false,...
    'start_at_trial', 0, ...
    'nb_new_trials',  2^(numel(this.params))+10*numel(this.params), ...
    'nb_local_iter',  20, ...
    'local_optim_options', optimset() ...
    );

if this.use_parallel
    opt.use_parallel = true;
end

% checks with what we have already
if isstruct(this.solver_options)
    fn = fieldnames(this.solver_options);
    for ifn = 1:numel(fn)
        field = fn{ifn};
        if isfield(opt, field)
            opt.(field) = this.solver_options.(field);
        end
    end
end

if nargin > 2
    opt = varargin2struct(opt, varargin{:});
end

if (nargin >= 2)&&gui
    choices = struct( ...
        'use_param_set_as_init','bool',...
        'start_at_trial', 'int', ...
        'nb_new_trials',  'int', ...
        'nb_local_iter',  'int', ...
        'local_optim_options', 'string' ...
        );
    tips = struct( ...
        'use_param_set_as_init','Use the samples in the parameter set used to create the problem as initial trials. Otherwise, starts with corners, then quasi-random sampling.',...
        'start_at_trial', 'Skip the trials before that. Use 0 if this is the first time you are solving this problem.', ...
        'nb_new_trials',  'Number of initial parameters used before going into local optimization.', ...
        'nb_local_iter',  'Number of iteration of Nelder-Mead algorithm for each trial.', ...
        'local_optim_options', 'Advanced local solver options. ' ...
        );
    gui_opt = opt;
    gui_opt.local_optim_options = 'default optimset()';
    
    opt = BreachOptionGui('Choose options for solver global_nelder_mead', gui_opt, choices, tips);
    close(opt.dlg);
    
    return;
    %gui_opt = gu.output;
    %gui_opt.local_optim_options = opt.local_optim_options;
    %opt = gui_opt;
end

this.solver_options = opt;


end
